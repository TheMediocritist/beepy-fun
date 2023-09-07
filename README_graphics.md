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
