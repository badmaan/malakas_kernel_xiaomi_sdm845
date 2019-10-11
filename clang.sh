#!/bin/bash
### MLX COMPILATION SCRIPT 
rm -rf /out
make kernelversion
date
###config ccache
export USE_CCACHE=1
export USE_PREBUILT_CACHE=1
export PREBUILT_CACHE_DIR=~/.ccache
export CCACHE_DIR=~/.ccache
ccache -M 30G

###set dirs
MLX=~/GIT/malakas_kernel_xiaomi_sdm845
AK=$MLX/anykernel
OUT=$MLX/out/arch/arm64/boot
KERNEL=~/Desktop/MLX
TC=/usr/bin

GCC32=$TC/arm-linux-gnueabi/bin 
GCC64=$TC/aarch64-linux-gnu/bin
CLANG=$TC/clang/bin
BINUTILS=$TC/binutils/bin

export KBUILD_BUILD_USER=thanas
export KBUILD_BUILD_HOST=MLX

###config compilers

export ARCH=arm64 && export SUBARCH=arm64 malakas_beryllium_defconfig

export CC=$TC/clang


export CROSS_COMPILE=$TC/aarch64-linux-gnu-

export LD_LIBRARY_PATH=/usr/lib64

###start compilation
mkdir -p out
make O=out clean
make O=out ARCH=arm64 malakas_beryllium_defconfig
LD_LIBRARY_PATH=/usr/lib64 \
PATH="/usr/bin:/usr/bin:${PATH}" \
make -j4 O=out \
        ARCH=arm64 \
        SUBARCH=arm64 \
        CC=clang \
        CROSS_COMPILE=aarch64-linux-gnu- \
        LD=ld.gold

###zip kernel
mkdir $KERNEL
mkdir $KERNEL/.compile
mv $OUT/Image.gz-dtb $AK/Image.gz-dtb
mv $MLX/out/include/generated/compile.h $KERNEL/.compile/compile.h
rm -rf $MLX/out
cd $AK
zip -r malakas_kernel_q_beryllium_69-65hz_$(date +"%Y-%m-%d").zip *
rm -rf Image.gz-dtb
mv malakas_kernel_q_beryllium_69-65hz_$(date +"%Y-%m-%d").zip $KERNEL

###push kernel
cd $KERNEL
adb kill-server
adb tcpip 5555
adb connect 192.168.3.101:5555
sleep 2
adb push malakas_kernel_q_beryllium_69-65hz_$(date +"%Y-%m-%d").zip /sdcard/MLX/malakas_kernel_q_beryllium_69-65hz_-$(date +"%Y-%m-%d").zip
adb reboot recovery
date
cd $MLX
