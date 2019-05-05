#!/bin/bash
rm -rf out
make kernelversion
export ARCH=arm64 && export SUBARCH=arm64 malakas_beryllium_defconfig
make malakas_beryllium_defconfig
make menuconfig
mv .config arch/arm64/configs/malakas_beryllium_defconfig2

