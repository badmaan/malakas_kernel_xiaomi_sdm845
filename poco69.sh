#!/bin/bash
rm -rf /out
make kernelversion
date
export ARCH=arm64 && export SUBARCH=arm64 malakas_beryllium_defconfig
#/scripts/config -e CLANG_LTO
#make ARCH=arm64 oldconfig
export CROSS_COMPILE=~/TOOLCHAIN/aarch64-linux-gnu/bin/aarch64-linux-gnu-
export CROSS_COMPILE_ARM32=~/TOOLCHAIN/arm-linux-gnueabi/bin/arm-linux-gnueabi-
#export CC=~/TOOLCHAIN/clang/bin/clang 
#export CLANG_TRIPLE=~/TOOLCHAIN/aarch64-linux-gnu/bin/aarch64-linux-gnu-
#export LD=~/TOOLCHAIN/aarch64-linux-gnu/aarch64-linux-gnu/bin/
#export LDGOLD=~/TOOLCHAIN/aarch64-linux-gnu/aarch64-linux-gnu/bin/
#export LDLLD=~/TOOLCHAIN/clang/bin/
export KBUILD_BUILD_USER=thanas
export KBUILD_BUILD_HOST=MLX
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache
mkdir -p out
make O=out clean
make O=out malakas_beryllium_defconfig
make -j$(nproc --all) O=out 
mv out/arch/arm64/boot/Image.gz-dtb ~/TOOLCHAIN/anykernel/Image.gz-dtb
rm -rf out
cd ~/TOOLCHAIN/anykernel
zip -r malakas_kernel_beryllium_69-65hz_$(date +"%Y-%m-%d").zip *
rm -rf Image.gz-dtb
mv malakas_kernel_beryllium_69-65hz_$(date +"%Y-%m-%d").zip ~/Desktop/MLX/
cd ~/Desktop/MLX/
ls
date
adb kill-server
adb tcpip 5555
adb connect 192.168.3.101:5555
sleep 2
adb push malakas_kernel_beryllium_69-65hz_$(date +"%Y-%m-%d").zip /sdcard/...MLX.../malakas_kernel_beryllium_69-65hz_-$(date +"%Y-%m-%d").zip
adb reboot recovery


