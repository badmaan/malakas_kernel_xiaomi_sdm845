#!/bin/bash
rm -rf out
green='\033[01;32m'
restore='\033[0m'
echo -e "${green}"
make kernelversion
echo -e "${restore}"
export ARCH=arm64 && export SUBARCH=arm64 malakas_beryllium_defconfig
make malakas_beryllium_defconfig
make menuconfig
mv .config arch/arm64/configs/malakas_beryllium_defconfig2
clear
if [ -e arch/arm64/configs/malakas_beryllium_defconfig2 ]; then
echo -e "${green}"
echo config regenerated
echo -e "${restore}"
else
echo -e "${green}"
echo done
echo -e "${restore}"
fi;
