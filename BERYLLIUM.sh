#!/bin/bash

rm -rf /out
make kernelversion
date

export ARCH=arm64 && export SUBARCH=arm64 malakas_beryllium_defconfig

export LD_LIBRARY_PATH=/home/x/TOOLCHAIN/clang/lib64/

export CROSS_COMPILE=/usr/bin/aarch64-linux-gnu-
export CROSS_COMPILE_ARM32=arm-linux-gnueabi-
export CLANG_TRIPLE=/usr/bin/aarch64-linux-gnu-
export CC=/home/x/TOOLCHAIN/clang/bin/clang

export USE_CCACHE=1
export USE_PREBUILT_CACHE=1
export PREBUILT_CACHE_DIR=~/.ccache
export CCACHE_DIR=~/.ccache
ccache -M 30G

export KBUILD_BUILD_USER=thanas
export KBUILD_BUILD_HOST=MLX

mkdir -p out
make O=out clean
make O=out malakas_beryllium_defconfig
make -j$(nproc --all) O=out #V=1

mv out/arch/arm64/boot/Image.gz-dtb ~/TOOLCHAIN/anykernel/Image.gz-dtb
rm -rf out
cd ~/TOOLCHAIN/anykernel
zip -r malakas_kernel_q_beryllium_69-65hz_$(date +"%Y-%m-%d").zip *
rm -rf Image.gz-dtb
mkdir ~/Desktop/MLX/
mv malakas_kernel_q_beryllium_69-65hz_$(date +"%Y-%m-%d").zip ~/Desktop/MLX/
cd ~/Desktop/MLX/
ls
date

adb kill-server
adb tcpip 5555
adb connect 192.168.3.101:5555
sleep 2
adb push malakas_kernel_q_beryllium_69-65hz_$(date +"%Y-%m-%d").zip /sdcard/MLX/malakas_kernel_q_beryllium_69-65hz_-$(date +"%Y-%m-%d").zip
adb reboot recovery


