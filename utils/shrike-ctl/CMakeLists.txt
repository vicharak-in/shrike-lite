cmake_minimum_required(VERSION 3.13)
include(pico_sdk_import.cmake)

project(shrike-ctl)

pico_sdk_init()

if (TARGET tinyusb_device)
	add_executable(shrike-ctl main.c)
    
    target_link_libraries(shrike-ctl 
        pico_stdlib 
        hardware_spi
    )
    
    pico_enable_stdio_usb(shrike-ctl 1)
    pico_enable_stdio_uart(shrike-ctl 0)
    pico_add_extra_outputs(shrike-ctl)
    
elseif(PICO_ON_DEVICE)
    message(WARNING "TinyUSB not available - not building USB example")
endif()
