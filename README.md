# Fun with Beepy
(Yet another) repo for exploring Beepy's fun potential

#### Basics install:
- [x] Post-install fixes
  - [x] Increase font size
  - [x] Automatic login
- [x] Tmux
  - [x] Status bar
  - [x] Wi-Fi menu
- [x] Display dithering

- [x] Games
  - [x] Gameboy emulator
  - [x] Doom
  - [ ] MAME



Running the following command will do everything checked in the list above. Use at your own risk.
```bash 
curl ....
```

#### Extras
- [ ] Graphics support
  - [x] DirectFB2
  - [ ] SDL2
  - [ ] FBGraphics (FBG)
  - [ ] PyGame (depends on SDL2)
  - [ ] Love2D (depends on SDL2)
- [ ] Graphical launcher/frontend

## Post-install fixes
Fix /boot/cmdline.txt and increase default font size to 8x16

## Install Tmux and add some flair
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

## Display driver with grayscale dithering
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

