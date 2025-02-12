# Please give us faster Arduino compile times

I feel like too much time is spent waiting for the progress bar on the Arduino IDE to move during the compile & upload stage, so I tried making this template file.
Why spend time waiting for a sketch to compile when you can spend even more time trying to optimize the sketch compilation and upload process?

As an added bonus, your sketch will only be re-compiled when its contents have changed, rather than everytime you want to upload a sketch

## Set-up instructions

1. install `arduino-cli` if you don't yet have it installed
2. run `chmod +x compile.sh` to make `compile.sh` executable
3. run `./compile.sh <folder_name>` to compile the sketch inside the folder and upload the build

## Intended file structure

```
├── .gitignore
├── Makefile
├── compile.sh
├── readme.md
└── test/ <-- Sketch you want to compile
    ├── build/
    └── test.ino <-- .ino file should have the same name as the file
└── foo/ <-- Sketch you want to compile
    ├── build/
    └── foo.ino <-- .ino file should have the same name as the file
```

## Using the <a href="https://arduino.github.io/arduino-cli/1.1/sketch-specification/#sketch-root-folder">sketch named `test`</a> as an example:

1. run `git clone https://github.com/SleepyWoodpecker/Arduino-CLI-Makefile-Template.git` to clone this repo
2. run `cd Arduino-CLI-Makefile-Template`
3. run `./compile.sh test` to compile, then upload the sketch inside `test`, since test is your compilation target
4. run `make monitor` to bring up the Serial Monitor in your terminal

## Note:

1. The Makefile currently compiles for esp-wrooms, as specified in the first line of the makefile `FQBN := espressif:esp32:esp32da`
2. If you would like to compile for a different board, you can try to look for your board using `arduino-cli board listall | grep --ignore-case "<name of board>"`

### TODO:

1. Support Windows shell
