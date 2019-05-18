#!/bin/bash
rm -rf /out
make kernelversion
export ARCH=arm64 && export SUBARCH=arm64 malakas_beryllium_defconfig
#/scripts/config -e CLANG_LTO
#make ARCH=arm64 oldconfig
export CROSS_COMPILE=~/TOOLCHAIN/gcc/bin/aarch64-linux-gnu- 
#export CC=~/TOOLCHAIN/dtc/bin/clang 
#export CLANG_TRIPLE=~/TOOLCHAIN/gcc/bin/aarch64-linux-gnu-
export LD=~/TOOLCHAIN/gcc/bin/aarch64-linux-gnu-ld.gold
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache
mkdir -p out
make O=out clean
make O=out malakas_beryllium_defconfig
make -j$(nproc --all) O=out 
mv out/arch/arm64/boot/Image.gz-dtb ~/TOOLCHAIN/anykernel/Image.gz-dtb
rm -rf out
cd ~/TOOLCHAIN/anykernel
zip -r malakas_kernel69-65hz-$(date +"%Y-%m-%d").zip *
rm -rf Image.gz-dtb
mv malakas_kernel69-65hz-$(date +"%Y-%m-%d").zip ~/Desktop
cd ~/Desktop
adb kill-server
adb tcpip 5555
adb connect 192.168.3.101:5555
sleep 2
adb push malakas_kernel69-65hz-$(date +"%Y-%m-%d").zip /sdcard/malakas_kernel69-65hz-$(date +"%Y-%m-%d").zip
adb reboot recovery


