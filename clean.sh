#!/bin/bash
rm -rf out
make mrproper
make O=out clean
echo "Μαλάκα!"
