FQBN := espressif:esp32:esp32da
# TODO: change this for other OS users
PORT := $(shell ls /dev/cu.usb* | head -n 1)
SKETCH_FILE_NAME ?= $(notdir ${CURDIR}.ino)
MONITOR_BAUD_RATE := $(shell sed -nE 's/.*Serial.begin\(([0-9]+)\).*/\1/p' ${SKETCH_FILE_NAME})
BUILD_PATH := ${CURDIR}/build/$(basename ${SKETCH_FILE_NAME})
# use a timestamp folder to prevent re-compilation
COMPILE_TIMESTAMP := ${BUILD_PATH}/.timestamp

# do some checks to make sure everything you want exists
ifndef PORT
$(error No usb serial port connected, please try again)
endif

ifndef SKETCH_FILE_NAME
$(error No sketch file name provided)
endif

# some scripts do not need a baud rate, so my solution to this would be to set a default baud rate
ifndef MONITOR_BAUD_RATE
MONITOR_BAUD_RATE = 115200
endif

compile : ${COMPILE_TIMESTAMP}

upload : ${COMPILE_TIMESTAMP}
	arduino-cli upload -p ${PORT} --fqbn ${FQBN} ${CURDIR} --input-dir ${BUILD_PATH}

${COMPILE_TIMESTAMP} : ${SKETCH_FILE_NAME}
	arduino-cli compile --fqbn ${FQBN} --build-path "${BUILD_PATH}" ${SKETCH_FILE_NAME} -v
	touch ${COMPILE_TIMESTAMP}

monitor:
	screen ${PORT} ${MONITOR_BAUD_RATE}

display_config:
	@echo "BOARD: ${FQBN}"
	@echo "PORT: ${PORT}"
	@echo "MONITOR BAUD RATE: ${MONITOR_BAUD_RATE}"
	@echo "SKETCH FILE: ${SKETCH_FILE_NAME}"
	@echo "BUILD PATH: ${BUILD_PATH}" 
	@echo ""
	@echo "---------------------------------------"
	@echo ""

