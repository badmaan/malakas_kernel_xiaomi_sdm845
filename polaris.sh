#!/bin/bash
rm -rf /out
make kernelversion
date
export ARCH=arm64 && export SUBARCH=arm64 malakas_polaris_defconfig
#/scripts/config -e CLANG_LTO
#make ARCH=arm64 oldconfig
export CROSS_COMPILE=~/TOOLCHAIN/gcc/bin/aarch64-linux-gnu-
export CROSS_COMPILE_ARM32=~/TOOLCHAIN/gcc32/bin/arm-linux-gnueabihf-
#export CC=~/TOOLCHAIN/dtc/bin/clang 
#export CLANG_TRIPLE=~/TOOLCHAIN/gcc/bin/aarch64-linux-gnu-
export LD=~/TOOLCHAIN/clang/bin/ld.lld
export KBUILD_BUILD_USER=thanas
export KBUILD_BUILD_HOST=MLX
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache
mkdir -p out
make O=out clean
make O=out malakas_polaris_defconfig
make -j$(nproc --all) O=out 
mv out/arch/arm64/boot/Image.gz-dtb ~/TOOLCHAIN/anykernel/Image.gz-dtb
rm -rf out
cd ~/TOOLCHAIN/anykernel
zip -r malakas_kernel_polaris_$(date +"%Y-%m-%d").zip *
rm -rf Image.gz-dtb
mv malakas_kernel_polaris_$(date +"%Y-%m-%d").zip ~/Desktop/MLX/
cd ~/Desktop/MLX/
ls
date


