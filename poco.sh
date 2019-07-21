#!/bin/bash
rm -rf /out
make kernelversion
date
export ARCH=arm64 && export SUBARCH=arm64 malakas_beryllium_defconfig
#/scripts/config -e CLANG_LTO
#make ARCH=arm64 oldconfig
export CROSS_COMPILE=~/TOOLCHAIN/aarch64-linux-gnu/bin/aarch64-linux-gnu-
export CROSS_COMPILE_ARM32=~/TOOLCHAIN/arm-linux-gnueabi/bin/arm-linux-gnueabi-
export CC=~/TOOLCHAIN/clang/bin/clang 
export CLANG_TRIPLE=~/TOOLCHAIN/aarch64-linux-gnu/bin/aarch64-linux-gnu-
#export LD=~/TOOLCHAIN/aarch64-linux-gnu/aarch64-linux-gnu/bin/
#export LDGOLD=~/TOOLCHAIN/aarch64-linux-gnu/aarch64-linux-gnu/bin/
#export LDLLD=~/TOOLCHAIN/clang/bin/
export KBUILD_BUILD_USER=thanas
export KBUILD_BUILD_HOST=MLX
export PATH=~/bin:$PATH
export USE_CCACHE=1
export USE_PREBUILT_CACHE=1
export PREBUILT_CACHE_DIR=~/.ccache
export CCACHE_DIR=~/.ccache
ccache -M 100G
mkdir -p out
make O=out clean
make O=out malakas_beryllium_defconfig
make -j$(nproc --all) O=out 
mv out/arch/arm64/boot/Image.gz-dtb ~/TOOLCHAIN/anykernel/Image.gz-dtb
rm -rf out
cd ~/TOOLCHAIN/anykernel
zip -r malakas_kernel_beryllium_$(date +"%Y-%m-%d").zip *
rm -rf Image.gz-dtb
mv malakas_kernel_beryllium_$(date +"%Y-%m-%d").zip ~/Desktop/MLX/
cd ~/Desktop/MLX/
ls
date
