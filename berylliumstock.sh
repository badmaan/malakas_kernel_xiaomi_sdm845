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
TC=~/TOOLCHAIN

GCC32=$TC/arm-linux-gnueabi/bin 
GCC64=$TC/aarch64-linux-gnu/bin
CLANG=$TC/clang/bin
BINUTILS=$TC/binutils/bin

export KBUILD_BUILD_USER=thanas
export KBUILD_BUILD_HOST=MLX

###config compilers

export ARCH=arm64 && export SUBARCH=arm64 malakas_beryllium_defconfig

#export CC=$CLANG/clang

#export CLANG_TRIPLE=$GCC64/aarch64-linux-gnu-

export CROSS_COMPILE=$GCC64/aarch64-linux-gnu-
export CROSS_COMPILE_ARM32=$GCC32/arm-linux-gnueabi-

#export LD=ld.gold

#export LD_LIBRARY_PATH=/usr/lib64
#export PATH="~/TOOLCHAIN/aarch64-linux-gnu/bin:~/TOOLCHAIN/clang/bin:${PATH}"

###start compilation / setup clang
mkdir -p out
make O=out clean
make O=out ARCH=arm64 malakas_beryllium_defconfig
#LD_LIBRARY_PATH=/home/x/TOOLCHAIN/clang/lib/
#PATH="/home/x/TOOLCHAIN/clang/bin:/home/x/TOOLCHAIN/aarch64-linux-gnu/bin:${PATH}" \
make -j$(nproc --all) O=out #\  #V=1  
        #ARCH=arm64 \
        #SUBARCH=arm64 \
        #LD=ld.gold \
        #CC=clang \
        #HOSTCC=clang \
        #CROSS_COMPILE=aarch64-linux-gnu- \
        #CROSS_COMPILE_ARM32=arm-linux-gnueabi-

###zip kernel
mkdir $KERNEL
mkdir $KERNEL/.compile
mv $OUT/Image.gz-dtb $AK/Image.gz-dtb
mv $MLX/out/include/generated/compile.h $KERNEL/.compile/compile.h
rm -rf $MLX/out
cd $AK
zip -r malakas_kernel_q_beryllium_$(date +"%Y-%m-%d").zip *
rm -rf Image.gz-dtb
mv malakas_kernel_q_beryllium_$(date +"%Y-%m-%d").zip $KERNEL

