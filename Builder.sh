#!/bin/sh

#################################################
##############  MADE BY ANOMALCHIK ##############
#### Please don't hit me for this script :D  ####
#################################################

BUILD_USER="anomalchik"
BUILD_HOST="sweetmachine"

############# TOOLCHAIN #############
ARM64TC=/home/anomalchik/Lolipop/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
ARMTC=/home/anomalchik/tch/arm-cortex_a7-linux-gnueabihf-linaro_4.9/bin/arm-cortex_a7-linux-gnueabihf-

############# DEFCONFIG ############
CM13Defconfig=alps_hongyu82_defconfig
CM12_1Defconfig=alps_defconfig
HermesDefconfig=hermes_defconfig

############# PATH #############
CM13KernelAlps=/home/anomalchik/mmkernel
CM12_1KernelAlps=/home/anomalchik/alps_kern
HermesKernelTest=/home/anomalchik/kernel_vanzo

############# COLORS #############
CRED="\033[0;31m"
CREDBOLD="\033[1;31m"
CGREEN="\033[1;32m"
CYELLOW="\033[1;33m"
CBLUE="\033[1;34m"
CNORMAL="\033[0m"

############# CM13 #############
BuildCM13()
{
cd $CM13KernelAlps
ExportParam
Build
	}

############# CM 12.1 #############
BuildCM12_1()
{
cd $CM12_1KernelAlps
ExportParam
Build
	}

############# Hermes #############
BuildHermes()
{
cd $HermesKernelTest
ExportParam
Build
	}

############# Main #############
Build()
{
echo $CGREEN"CLEAN"
make mrproper
echo $CBLUE"Defconfig: $defconfig"
make $defconfig
echo $CYELLOW"Make"$CNORMAL
make -j4
}

ExportParam()
{
echo $CYELLOW"Project: "$CREDBOLD"$Project"$CNORMAL
export ARCH=$arm
echo "ARCH=$CYELLOW$arm"$CNORMAL
export KBUILD_BUILD_USER=$BUILD_USER
echo "BUILD_USER=$CBLUE$BUILD_USER"$CNORMAL
export KBUILD_BUILD_HOST=$BUILD_HOST
echo "BUILD_HOST=$CBLUE$BUILD_HOST"$CNORMAL
export CROSS_COMPILE=$CC
echo "TOOLCHAIN IS: $CYELLOW""$CC"$CNORMAL
}



RestartScript()
{
cd /home/anomalchik
sh Builder.sh
}

############# MAIN MENU #############
echo " "
echo $CREDBOLD"Build script by Anomalchik"
echo $CYELLOW"Script Version 0.5a"$CNORMAL
#echo "Script use AndImgTool from 4PDA"
echo "1 - Build CM 13 kernel"
echo "2 - Build CM 12.1 kernel"
echo "3 - Build Hermes kernel"
echo -n "Enter Option: "
read opt
case $opt in
	1)
		Project="CM13 Kernel"
		arm=arm
		defconfig=$CM13Defconfig
		CC=$ARMTC
		BuildCM13
		RestartScript
		exit
		;;
	2)	
		Project="CM12.1 Kernel"
		arm=arm
		defconfig=$CM12_1Defconfig
		CC=$ARMTC
		BuildCM12_1
		RestartScript
		exit
		;;
	3)
		Project="Hermes"
		arm=arm64
		defconfig=$HermesDefconfig
		CC=$ARM64TC
		BuildHermes
		RestartScript		
		exit
		;;
esac
