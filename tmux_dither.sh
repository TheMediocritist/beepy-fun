#!/bin/bash

# Name:         tmux_dither.sh
# Version:      0.01b
#
# Author:       TheMediocritist
# Date:         September 2023

function main_menu() {
    
    # Get the current mono-cutoff value
    current_value=$(cat /sys/firmware/beepy/mono-cutoff)

    # Initialise the cmd array with the display-menu command
    cmd=("tmux" "display-menu" "-T" "#[align=centre] Display Settings" "-x" "R" "-y" "S")
    
    # Define an array for menu items
    menu_items=(
        "Bayer 4x4 dithering"
        "Mono cutoff  32"
        "Mono cutoff  64"
        "Mono cutoff  96"
        "Mono cutoff 128"
        "Mono cutoff 160"
        "Mono cutoff 192"
        "Mono cutoff 224"
    )
    
    # Define an array for corresponding menu keys
    menu_keys=("a" "b" "c" "d" "e" "f" "g" "h")

    # Loop through menu items
    for ((i=0; i<${#menu_items[@]}; i++)); do
        item="${menu_items[$i]}"
        key="${menu_keys[$i]}"
        
        if [ "$current_value" -eq "$((i * 32))" ]; then
            cmd+=("#[align=left][*] $item" "$key" "run -b \"echo $((i * 32)) > /sys/firmware/beepy/mono-cutoff\"")
        else
            cmd+=("#[align=left][ ] $item" "$key" "run -b \"echo $((i * 32)) > /sys/firmware/beepy/mono-cutoff\"")
        fi
    done

    # Create tmux menu
    "${cmd[@]}"
}

main_menu
