# Fun with Beepy
(Yet another) repo for exploring Beepy's fun potential.
Running anything on this page is your decision. Do so at your own risk.

#### Basic setup:
 - [Post-install fixes](#postfix)
 - [Install & set up Tmux](#tmux)
 - [Install grayscale dithering display driver](#grayscale)
```bash 
curl ....
```

#### Add some games
 - Gameboy emulator
 - Doom
 - Zork
```bash 
curl ....
```



Running the following command will do everything checked in the list above. Use at your own risk.


#### Extras
- [ ] Graphics support
  - [x] DirectFB2
  - [ ] SDL2
  - [ ] FBGraphics (FBG)
  - [ ] PyGame (depends on SDL2)
  - [ ] Love2D (depends on SDL2)
- [ ] Graphical launcher/frontend

## <a name="postfix"></a>Post-install fixes
Fix /boot/cmdline.txt and increase default font size to 8x16
```bash
sudo set -i 's/8x8/8x16/g' /boot/cmdline.txt
```
Log in automatically
```bash
sudo raspi-config nonint do_boot_behaviour B2
```

## <a name="tmux"></a> Install Tmux and add some flair
#### Status bar
* [x] Clock
* [x] Battery %
* [x] Wi-Fi connection & signal strength

#### Extra menus
* [x] Wi-Fi connection manager/switcher
* [ ] Bluetooth connection manager/switcher

```bash
sudo apt install tmux
cd ~/
wget https://raw.githubusercontent.com/TheMediocritist/beepy-fun/main/.tmux.conf
mkdir .conf & cd .conf
wget https://raw.githubusercontent.com/TheMediocritist/beepy-fun/main/tmux_wifi_manager.sh
wget https://raw.githubusercontent.com/TheMediocritist/beepy-fun/main/tmux_wifi_status.sh
```

## <a name="grayscale"></a> Display driver with grayscale dithering
```bash
git clone BLAHBLABLAH
```

Post-install fixes

### DirectFB2
```bash
wget https://raw.githubusercontent.com/TheMediocritist/beepy-directfb2/main/build_dfb2.py
chmod +x build_dfb2.py
./build_dfb2.py
```
Then wait. And wait some more...

### SDL2
Tell SDL to use the directfb backend
```bash
export SDL_VIDEODRIVER=directfb
```

Interesting... This is using the RetroPie Bullseye image:
```bash
love
Error: Could not initialize SDL video subsystem (directfb not available)
stack traceback:
        [string "boot.lua"]:777: in function <[string "boot.lua"]:773>
        [C]: at 0x0002fbcc
        [C]: in function 'require'
        [string "boot.lua"]:505: in function <[string "boot.lua"]:380>
        [C]: in function 'xpcall'
        [string "boot.lua"]:787: in function <[string "boot.lua"]:780>
        [C]: in function 'xpcall'
```

