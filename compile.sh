#!/bin/sh

# check that the user has specified a file name
if [ $# -ne 1 ]; then
  echo "ERROR: No .ino file for compilation specified"
  exit 1
fi

# check that arduino-cli is installed
if ! eval "arduino-cli" >/dev/null 2>&1; then
  echo "ERROR: Please install arduino-cli first"
  exit 2
fi

# run make with the specified file name
make SKETCH_FILE_NAME="$1"

echo ""
echo "--------------- Finished compilation ---------------"
echo ""

make upload SKETCH_FILE_NAME="$1"

echo ""
echo "----------------- Finished upload -----------------"
echo ""