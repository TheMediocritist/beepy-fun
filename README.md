# Fun with Beepy
(Yet another) repo exploring Beepy's fun potential. It's mainly for me - so I can get everything set up the way I like when I inevitably break something and have to start from a fresh SD card.

If you choose to run anything from here you do so at your own risk. 

### Basic setup
This step increases the size of fonts and boots directly into Tmux with time, wifi and battery indicators and wifi manager.

Details:
 - [Post-install fixes](#postfix)
 - [Install & set up Tmux](https://github.com/TheMediocritist/beepy-fun/tree/main#-install-tmux-and-add-some-flair)
 - [Install grayscale dithering display driver](#grayscaledither)

Pick and choose by following the links above, or run the following to install them all:
```bash 
curl ....
```

### Games
 - [Gameboy emulator](https://github.com/TheMediocritist/beepy-fun/blob/main/README.md#gameboy-emulator-)
 - Doom
 - Zork
   
Pick and choose by following the links above, or run the following to install them all:
```bash 
curl ....
```
### Apps
 - [pDiary](https://github.com/TheMediocritist/beepy-fun/tree/main#pDiary) for Doogie Howser vibes 
 - [Tui-Journal](https://github.com/TheMediocritist/beepy-fun/tree/main#Tui-Journal)
 - 3
 - 4

Pick and choose by following the links above, or run the following to install them all:
```bash 
curl ....
```

### Extras
- [ ] Graphics support
  - [x] DirectFB2
  - [ ] SDL2
  - [ ] FBGraphics (FBG)
  - [ ] PyGame (depends on SDL2)
  - [ ] Love2D (depends on SDL2)
- [ ] Graphical launcher/frontend

# Basic Setup
### Post-install fixes
Fix /boot/cmdline.txt and increase default font size to 8x16
```bash
sudo set -i 's/8x8/8x16/g' /boot/cmdline.txt
```
Log in automatically
```bash
sudo raspi-config nonint do_boot_behaviour B2
```
Launch Tmux at login
```bash
...
```

### Install Tmux and add some flair
#### Status bar
* [x] Clock
* [x] Battery %
* [x] Wi-Fi connection & signal strength

#### Extra menus
* [x] [Tmux + n] Wi-Fi connection manager/switcher
* [x] [Tmux + k] Sym keymap guide popup
* [ ] [Tmux + v] Set display dithering/mono cutoff value
* [ ] Bluetooth connection manager/switcher

Note: repo version of tmux is _old!_

Install from source:
```bash
sudo apt remove tmux
sudo apt update
sudo apt install -y libevent-dev automake libncurses-dev
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure && make
sudo make install
```
Now add some fun:
```bash
cd ~/
wget https://raw.githubusercontent.com/TheMediocritist/beepy-fun/main/.tmux.conf
mkdir .conf & cd .conf
wget https://raw.githubusercontent.com/TheMediocritist/beepy-fun/main/tmux_wifi_manager.sh
wget https://raw.githubusercontent.com/TheMediocritist/beepy-fun/main/tmux_wifi_status.sh
wget https://raw.githubusercontent.com/TheMediocritist/beepy-fun/main/tmux_keymap.sh
```
Notes:
 - The addon scripts are located in a hidden folder called `~/.conf`, in case you wish to edit or remove them.
 - Tmux configuration is in the hidden file `~/.tmux.conf`.
 - Reboot is required, but can wait...

### Display driver with grayscale dithering
```bash
git clone https://github.com/TheMediocritist/beepy_sharp_drm ~/sharp_drm
cd ~/sharp_drm
make
sudo make install
sudo reboot
```

#### Post-install fixes
Notes
 - The display driver is using 32 bits per pixel RBGA. 
 - The terminal is using a variety of colours for highlighting and different file/folder types.
 - The linux terminal 'black' is actually a dark gray, and 'white' is actually off-white.
So...

# Games
### Gameboy Emulator
Fix /boot/cmdline.txt and increase default font size to 8x16
```bash
...
```
### Doom
Fix /boot/cmdline.txt and increase default font size to 8x16
```bash
# clone and build
cd ~/
git clone https://github.com/TheMediocritist/beepy_doom
cd beepy_doom
make

# download shareware WAD file (level data)
wget https://distro.ibiblio.org/slitaz/sources/packages/d/doom1.wad
```
### Zork
Zork is a text-based adventure game from 1977-ish, with various 
The version here is a lightly modified version of [Link](goes here) with the output re-formatted to fit within 50 characters and 15 lines (for 8x16 Beepy font). Where text overflows 15 lines, it will pause until a key is pressed.
```bash
# install dependencies
sudo apt install libboost-all-dev

# clone and build
cd ~/
git clone https://github.com/TheMediocritist/beepy_zork1
cd beepy_zork1
mkdir build
cd build
cmake ..
make
```
# Apps
### pDiary
[pDiary](https://github.com/manipuladordedados/pdiary)) is a journalling app with major Doogie Howser vibes. Old people will understand.
```bash
...
```

### Tui-Journal
[Tui-Journal](https://github.com/ammarabouzor/tui-journal) is a journalling app with major Doogie Howser vibes. Old people will understand.
```bash
# Install dependencies
sudo apt install -y libssl-dev
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
# Install tui-journal
cargo install tui-journal
```
Note: Building tui-journal is slow. I'm not kidding; maybe a couple of hours on a Pi Zero.
