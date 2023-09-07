#!/bin/bash

# Name:         tmux_wifi_manager.sh
# Version:      0.01b
#
# Author:       TheMediocritist
# Sidekick:     ChatGPT 3.5 <- All complaints directed here, thank you...
# Origins:      Inspired by c3r34lk1ll3rs tmux-networkmanager (https://github.com/c3r34lk1ll3r/tmux-networkmanager)
# Date:         September 2023
#
# Description:  Tmux plugin for easily swapping between Wi-Fi networks, intended for Beepy users
# How to use:   1) Save it somewhere
#               2) Edit ~/.tmux.conf, adding a line to bind it, e.g.: bind-key n run -b ~/tmux_wifi_manager.sh
#               3) Press Tmux key + r to reload configuration
#               4) Press Tmux key + <selected bind key> to activate the menu
#
# Indicators:   <▆> = Active network
#               < > = Inactive network
#                -  = Unknown/new network
#
# Eh:           When selecting a Wi-Fi network the script will:
#               - if selected is active, turn it off (connection down)
#               - if another is active turn _that_ off (connection down)
#               - if selected is known, turn it on (connection up)
#               - if selected is new, connect it (wifi connect)
#
# For reference:
#   Restart NetworkManager
#     systemctl restart NetworkManager
#   Connect
#     sudo nmcli dev wifi connect network-ssid password "network-password"
#   Disconnect
#     nmcli con down ssid
#   List saved connections
#     nmcli con show
#   Switch between saved connections
#     nmcli connection down ssid OR nmcli c d ssid
#     then
#     nmcli con up ssid
#   Check if wi-fi device is enabled
#     nmcli radio wifi
#   Turn on disabled wi-fi device
#     nmcli radio wifi on
#   Turn off
#     nmcli radio wifi off


function pad_or_trim_string() {
    # helper function
    # takes any length string and outputs <chars> length string by either:
    #   - padding with spaces
    #   - truncating - truncated strings will have '...' as the last 3 characters 
    
    local input="$1"
    local length="$2"
    
    # If the input string is longer than the specified length, truncate it
    if [ ${#input} -gt "$length" ]; then
        echo "${input:0:$((length-3))}..."
    else
        # If the input string is shorter or equal to the specified length, pad it with spaces
        printf "%-*s" "$length" "$input"
    fi
}

function signal_strength_icon() {
    # helper function
    # creates 6 character signal strength 'icon'
    # graph replaced with unavailable unicode to get black square; might revisit the graphs once fonts are updated.
    # Improved by @anonymoushindeiru (though I did have to check for eggplants).

    local signal="$1"
    
    case $((
        $signal>=75 ? 4 :
        $signal>=50 ? 3 :
        $signal>=25 ? 2 :
        $signal>=1 ? 1 : 0)) in
            0) BAR_STR='[ XX ]';;
            1) BAR_STR='[▆   ]';;
            2) BAR_STR='[▆▆  ]';;
            3) BAR_STR='[▆▆▆ ]';;
            4) BAR_STR='[▆▆▆▆]';;
    esac
    
    echo "$BAR_STR"
}

function main_menu() {
    
    # short is used to allocate shortcut letters to menu items
    short=($(echo {a..p}))
    
    active_ssid=false
    
    # Initialise the cmd array with the display-menu command
    cmd=("tmux" "display-menu" "-T" "#[align=centre] Wi-Fi Settings" "-x" "R" "-y" "S")
    
    # check if wifi is currently on/off
    wifi_status=$(sudo nmcli radio wifi)
    
    if [[ $wifi_status == "disabled" ]]; then
        cmd+=("#[align=left]Turn Wi-Fi On" "o" "run -b \"sudo nmcli radio wifi on > /dev/null\"")
    else
        # get current active (variable) and inactive connections (array): note sudo or only display active connection if active
        connections=$(nmcli -t -f NAME,DEVICE connection show)
        while IFS= read -r line; do
            # Split the line into fields
            IFS=' ' read -r -a fields <<< "$line"
            
            # Extract the name and device from the fields
            name="${fields[0]}"
            device="${fields[1]}"
        
            # Check if the device is connected to wlan0
            if [ "$device" == "wlan0" ]; then
                active_ssid="$name"
            else
                inactive_ssids+=("$name")
            fi
        done <<< "$connections"
        
        # Run nmcli and store its output - replace * because it's a special character in bash and does annoying stuff
        wifi_info=$(sudo nmcli dev wifi | tr '*' ">")
        
        # Split wifi_info into an array using newline as the delimiter
        IFS=$'\n' read -rd '' -a wifi_array <<< "$wifi_info"
        
        # Loop through the array, skipping the first line
        for ((i = 1; i < ${#wifi_array[@]}; i++)); do
            
            # Split the line into an array using double-space as the delimeter - prob. a better way to do this and not lose blanks
            IFS=$'  ' read -rd '' -a line <<< "${wifi_array[i]}"
            
            if [[ "${line[0]}" == ">" ]]; then
                is_on=true
                ssid=${line[2]}
                active="<▆>"
                signal=$(signal_strength_icon ${line[7]})
            else
                is_on=false
                ssid=${line[1]}
                if [[ "${inactive_ssids[@]}" =~ "$ssid" ]]; then
                    active="< >"
                else
                    active=" - "
                fi
                signal=$(signal_strength_icon ${line[6]})
            fi
            ssid_pad=$(pad_or_trim_string "$ssid" 13)
            shortcut=${short[$i-1]}
            
            # command and line strings
            command_down="run -b \"sudo nmcli c d '$ssid' > /dev/null\""
            command_up="run -b \"sudo nmcli c u '$ssid' > /dev/null\""
            command_downup="run -b \"sudo nmcli c d '$active_ssid' > /dev/null && run -b \"sudo nmcli c u '$ssid' > /dev/null\""
            command_connect="command-prompt -p 'Password: ' \"run -b 'sudo nmcli dev wifi connect $ssid password \"%%\" > /dev/null'\""
            line_restart=("#[align=left]Restart NetworkManager" "r" "run -b \"sudo systemctl restart NetworkManager\"")
            line_wifi_off=("#[align=left]Turn Wi-Fi Off" "o" "run -b \"sudo nmcli radio wifi off > /dev/null\"")
            
            # Add the current item to cmd array
            cmd+=("#[align=left]$active $ssid_pad $signal" "$shortcut")
            
            # Add command string to current line:
            if [[ $is_on == true ]]; then
                cmd+=("$command_down")
            elif [[ $active == "< >" && $active_ssid == false ]]; then
                cmd+=("$command_up")
            elif [[ $active == "< >" ]]; then
                cmd+=("$command_downup")
            else
                cmd+=("$command_connect")
            fi
            
            # Limit to the top 11 networks
            if [[ $i -eq 11 ]]; then
                break
            fi
        done
        
        # Draw a divider line
        cmd+=("-#[align=centre]------" "" "")
        
        # Add the "Restart NetworkManager" option
        cmd+=("${line_restart[@]}")
        
        # Add the "Turn Wi-Fi On/Off" option
        cmd+=("${line_wifi_off[@]}")
    fi
    
    # Print debug information
    #printf '%s ' "${cmd[@]}"
    #echo
    #for item in "${cmd[@]}"; do
    #   echo "$item"
    #done
    
    # Create tmux menu
    "${cmd[@]}"
}

main_menu
