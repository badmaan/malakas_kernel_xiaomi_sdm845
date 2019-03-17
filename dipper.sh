#!/bin/bash
#git pull
rm -rf /out
make kernelversion
make clean && make mrproper
export ARCH=arm64 && export SUBARCH=arm64 malakas_dipper_defconfig
export CROSS_COMPILE=~/TOOLCHAIN/gcc/bin/aarch64-linux-gnu-
export CC=~/TOOLCHAIN/clang9/bin/clang 
export CLANG_TRIPLE=~/TOOLCHAIN/sdclang/aarch64-linux-android
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache
export <OUT_DIR> =out
#make b_defconfig
#make menuconfig
mkdir -p out
make O=out clean
make O=out malakas_dipper_defconfig
make -j$(nproc --all) O=out 
mv out/arch/arm64/boot/Image.gz-dtb ~/TOOLCHAIN/anykernel/Image.gz-dtb
rm -rf out
cd ~/TOOLCHAIN/anykernel
zip -r malakas_kernel_dipper-$(date +"%Y-%m-%d").zip *
rm -rf Image.gz-dtb
mv malakas_kernel_dipper-$(date +"%Y-%m-%d").zip ~/Desktop
cd ~/Desktop



