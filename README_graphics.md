# goes here

The goal here is to explore the options for 

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

## Random stuff
How to configure directfb: https://manpages.ubuntu.com/manpages/focal/en/man5/directfbrc.5.html

# SDL attempt 4017
using RetroPie SDL version
./autogen.sh
./configure --enable-video-rpi --enable-video-kmsdrm --enable-video-directfb --disable-video-opengl

SDL2 Configure Summary:
Building Shared Libraries
Building Static Libraries
Enabled modules : atomic audio video render events joystick haptic hidapi sensor power filesystem threads timers file loadso cpuinfo assembly
Assembly Math   :
Audio drivers   : disk dummy oss alsa(dynamic) sndio(dynamic)
Video drivers   : dummy x11(dynamic) directfb(dynamic) kmsdrm(dynamic) opengl_es1 opengl_es2 vulkan
X11 libraries   : xcursor xdbe xinerama xinput2 xinput2_multitouch xfixes xrandr xscrnsaver xshape xvidmode
Input drivers   : linuxev linuxkd
Enable virtual joystick APIs : YES
Using libsamplerate : YES
Using libudev       : YES
Using dbus          : YES
Using ime           : YES
Using ibus          : YES
Using fcitx         : YES

make (or make -j4 if we've got a Zero 2
sudo make install


Working
cpi@beepy-retro:~/beepy-directfb2/src/DirectFB-examples/build/src $ sudo ./df_andi

   ~~~~~~~~~~~~~~~~~~~~~~~~~~| DirectFB 2.0.0  |~~~~~~~~~~~~~~~~~~~~~~~~~~
        (c) 2017-2023  DirectFB2 Open Source Project (fork of DirectFB)
        (c) 2012-2016  DirectFB integrated media GmbH
        (c) 2001-2016  The world wide DirectFB Open Source Community
        (c) 2000-2004  Convergence (integrated media) GmbH
      ----------------------------------------------------------------

(*) DirectFB/Core: Single Application Core. (2023-09-07 23:35)
(*) DRMKMS/System: Using device /dev/dri/card0 (default)
(*) DRMKMS/System: Found 1 connectors, 1 encoders, 1 planes
(*) DirectFB/Input: beepy-kbd (1) 0.1 (DirectFB)
(*) DirectFB/Input: vc4-hdmi (2) 0.1 (DirectFB)
(*) DirectFB/Input: Hot-plug detection enabled with Linux Input
(*) DirectFB/Graphics: Genefx Software Rasterizer 0.7 (DirectFB)
(*) DRMKMS/Screen: Default mode is 400x240 (1 modes in total)
(*) DirectFB/Core/WM: Default 0.3 (DirectFB)
(*) Direct/Interface: Loaded 'DGIFF' implementation of 'IDirectFBFont'
(*) Direct/Interface: Loaded 'DFIFF' implementation of 'IDirectFBImageProvider'

cpi@beepy-retro:~/beepy-directfb2/src/DirectFB-examples/build/src $ sudo ./df_matrix

   ~~~~~~~~~~~~~~~~~~~~~~~~~~| DirectFB 2.0.0  |~~~~~~~~~~~~~~~~~~~~~~~~~~
        (c) 2017-2023  DirectFB2 Open Source Project (fork of DirectFB)
        (c) 2012-2016  DirectFB integrated media GmbH
        (c) 2001-2016  The world wide DirectFB Open Source Community
        (c) 2000-2004  Convergence (integrated media) GmbH
      ----------------------------------------------------------------

(*) DirectFB/Core: Single Application Core. (2023-09-07 23:35)
(*) DRMKMS/System: Using device /dev/dri/card0 (default)
(*) DRMKMS/System: Found 1 connectors, 1 encoders, 1 planes
(*) DirectFB/Input: beepy-kbd (1) 0.1 (DirectFB)
(*) DirectFB/Input: vc4-hdmi (2) 0.1 (DirectFB)
(*) DirectFB/Input: Hot-plug detection enabled with Linux Input
(*) DirectFB/Graphics: Genefx Software Rasterizer 0.7 (DirectFB)
(*) DRMKMS/Screen: Default mode is 400x240 (1 modes in total)
(*) DirectFB/Core/WM: Default 0.3 (DirectFB)
(!) DRMKMS/Layer: drmModePageFlip() failed!

cpi@beepy-retro:~/beepy-directfb2/src/DirectFB-examples/build/src $ sudo ./df_layers

   ~~~~~~~~~~~~~~~~~~~~~~~~~~| DirectFB 2.0.0  |~~~~~~~~~~~~~~~~~~~~~~~~~~
        (c) 2017-2023  DirectFB2 Open Source Project (fork of DirectFB)
        (c) 2012-2016  DirectFB integrated media GmbH
        (c) 2001-2016  The world wide DirectFB Open Source Community
        (c) 2000-2004  Convergence (integrated media) GmbH
      ----------------------------------------------------------------

(*) DirectFB/Core: Single Application Core. (2023-09-07 23:35)
(*) DRMKMS/System: Using device /dev/dri/card0 (default)
(*) DRMKMS/System: Found 1 connectors, 1 encoders, 1 planes
(*) DirectFB/Input: beepy-kbd (1) 0.1 (DirectFB)
(*) DirectFB/Input: vc4-hdmi (2) 0.1 (DirectFB)
(*) DirectFB/Input: Hot-plug detection enabled with Linux Input
(*) DirectFB/Graphics: Genefx Software Rasterizer 0.7 (DirectFB)
(*) DRMKMS/Screen: Default mode is 400x240 (1 modes in total)
(*) DirectFB/Core/WM: Default 0.3 (DirectFB)
(*) Direct/Interface: Loaded 'DGIFF' implementation of 'IDirectFBFont'
(!) DRMKMS/Layer: drmModeSetCrtc( crtc_id 34, fb_id 37, xy 0,0, connector_id 31, mode 400x240@0Hz ) failed at index 0!
    --> Invalid argument
(!) Core/LayerRegion: Could not set region!
    --> An invalid argument has been specified
(!) Core/LayerRegion: dfb_layer_region_realize() in dfb_layer_region_flip_update() failed!
    --> An invalid argument has been specified
(!) DRMKMS/Layer: drmModeSetCrtc( crtc_id 34, fb_id 37, xy 0,0, connector_id 31, mode 400x240@0Hz ) failed at index 0!
    --> Invalid argument
(!) Core/LayerRegion: Could not set region!
    --> An invalid argument has been specified
(!) Core/LayerRegion: dfb_layer_region_realize() in dfb_layer_region_flip_update() failed!
    --> An invalid argument has been specified
(!) DRMKMS/Layer: drmModeSetCrtc( crtc_id 34, fb_id 37, xy 0,0, connector_id 31, mode 400x240@0Hz ) failed at index 0!
    --> Invalid argument
(!) Core/LayerRegion: Could not set region!
    --> An invalid argument has been specified
(!) Core/LayerRegion: dfb_layer_region_realize() in dfb_layer_region_flip_update() failed!
    --> An invalid argument has been specified
(!) DRMKMS/Layer: drmModeSetCrtc( crtc_id 34, fb_id 37, xy 0,0, connector_id 31, mode 400x240@0Hz ) failed at index 0!
    --> Invalid argument
(!) Core/LayerRegion: Could not set region!
    --> An invalid argument has been specified
(!) Core/LayerRegion: dfb_layer_region_realize() in dfb_layer_region_flip_update() failed!
    --> An invalid argument has been specified
(!) DRMKMS/Layer: drmModeSetCrtc( crtc_id 34, fb_id 37, xy 0,0, connector_id 31, mode 400x240@0Hz ) failed at index 0!
    --> Invalid argument
(!) Core/LayerRegion: Could not set region!
    --> An invalid argument has been specified
(!) Core/LayerRegion: dfb_layer_region_realize() in dfb_layer_region_flip_update() failed!
    --> An invalid argument has been specified
(!) DRMKMS/Layer: drmModeSetCrtc( crtc_id 34, fb_id 37, xy 0,0, connector_id 31, mode 400x240@0Hz ) failed at index 0!
    --> Invalid argument
(!) Core/LayerRegion: Could not set region!
    --> An invalid argument has been specified
(!) Core/LayerRegion: dfb_layer_region_realize() in dfb_layer_region_flip_update() failed!
    --> An invalid argument has been specified
(!) DRMKMS/Layer: drmModeSetCrtc( crtc_id 34, fb_id 37, xy 0,0, connector_id 31, mode 400x240@0Hz ) failed at index 0!
    --> Invalid argument
(!) Core/LayerRegion: Could not set region!
    --> An invalid argument has been specified
(!) Core/LayerRegion: dfb_layer_region_realize() in dfb_layer_region_flip_update() failed!
    --> An invalid argument has been specified
(!) DRMKMS/Layer: drmModeSetCrtc( crtc_id 34, fb_id 37, xy 0,0, connector_id 31, mode 400x240@0Hz ) failed at index 0!
    --> Invalid argument
(!) Core/LayerRegion: Could not set region!
    --> An invalid argument has been specified
(!) Core/LayerRegion: dfb_layer_region_realize() in dfb_layer_region_flip_update() failed!
    --> An invalid argument has been specified
(!) DRMKMS/Layer: drmModeSetCrtc( crtc_id 34, fb_id 37, xy 0,0, connector_id 31, mode 400x240@0Hz ) failed at index 0!
    --> Invalid argument
(!) Core/LayerRegion: Could not set region!
    --> An invalid argument has been specified
(!) Core/LayerRegion: dfb_layer_region_realize() in dfb_layer_region_flip_update() failed!
    --> An invalid argument has been specified
(!) DRMKMS/Layer: drmModeSetCrtc( crtc_id 34, fb_id 37, xy 0,0, connector_id 31, mode 400x240@0Hz ) failed at index 0!
    --> Invalid argument
(!) Core/LayerRegion: Could not set region!
    --> An invalid argument has been specified
(!) Core/LayerRegion: dfb_layer_region_realize() in dfb_layer_region_flip_update() failed!
    --> An invalid argument has been specified
(!) DRMKMS/Layer: drmModeSetCrtc( crtc_id 34, fb_id 37, xy 0,0, connector_id 31, mode 400x240@0Hz ) failed at index 0!
    --> Invalid argument
(!) Core/LayerRegion: Could not set region!
    --> An invalid argument has been specified
(!) Core/LayerRegion: dfb_layer_region_realize() in dfb_layer_region_flip_update() failed!
    --> An invalid argument has been specified
(!) DRMKMS/Layer: drmModeSetCrtc( crtc_id 34, fb_id 37, xy 0,0, connector_id 31, mode 400x240@0Hz ) failed at index 0!
    --> Invalid argument
(!) Core/LayerRegion: Could not set region!
    --> An invalid argument has been specified
(!) Core/LayerRegion: dfb_layer_region_realize() in dfb_layer_region_flip_update() failed!
    --> An invalid argument has been specified
(!) DRMKMS/Layer: drmModeSetCrtc( crtc_id 34, fb_id 37, xy 0,0, connector_id 31, mode 400x240@0Hz ) failed at index 0!
    --> Invalid argument

#### After readinng...
(https://github.com/directfb2/DirectFB2/issues/90)[https://github.com/directfb2/DirectFB2/issues/90]

Shift drivers then make symlinks
sudo ln -sf /usr/local/lib/libfusion.so /usr/local/lib/libfusion-2.0.so
sudo ln -sf /usr/local/lib/libdirect.so /usr/local/lib/libdirect-2.0.so
sudo ln -sf /usr/local/lib/libdirectfb.so /usr/local/lib/libdirectfb-2.0.so

export PKF_CONFIG_PATH=/usr/local/lib/pkgconfig/

Rebuild SDL, explicitly with directfb
./autogen.sh
./configure --enable-video-rpi --enable-video-kmsdrm --enable-video-directfb --disable-video-opengl --disable-arm-neon --disable directfb-shared CFLAGS="-I/usr/local/lib/"
