# Fun with Beepy
(Yet another) repo exploring Beepy's fun potential. It's mainly for me - so I can get everything set up the way I like when I inevitably break something and have to start from a fresh SD card.

If you choose to run anything from here you do so at your own risk. 

#### Basic setup
This step increases the size of fonts and boots directly into Tmux with time, wifi and battery indicators and wifi manager.

Details:
 - [Post-install fixes](#postfix)
 - [Install & set up Tmux](https://github.com/TheMediocritist/beepy-fun/tree/main#-install-tmux-and-add-some-flair)
 - [Install grayscale dithering display driver](#grayscaledither)

Install all:
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
#### Neat apps
 - 1
 - 2
 - 3
 - 4


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

## <a name="grayscaledither"></a> Display driver with grayscale dithering
```bash
git clone https://github.com/TheMediocritist/beepy_sharp_drm ~/sharp_drm
cd ~/sharp_drm
make
sudo make install
sudo reboot
```

Post-install fixes


