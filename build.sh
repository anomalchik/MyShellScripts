device_file=buildscript/current_device.txt
buildtype_file=buildscript/build_type.txt
cleantype_file=buildscript/clean_type.txt

device=$(cat $device_file)
buildtype=$(cat $buildtype_file)
cleantype=$(cat $cleantype_file)

helpmtd()
{
echo "This is help screen!
Script commands:
########################################################
#    -jset         - set java version                  #
#    -markw        - set device to markw               #
#    -mido         - set device to mido                #
#    -Z00RD        - set device to Asus Z00RD          #
#    -cleanall     - clean out directory               #
#    -cleaninstall - clean builded files               #
#    -nonclean     - disable clean                     #
#    -bootimg      - set build type for make bootimg   #
#    -build        - set build type for full build     #
########################################################"
}

JavaSettings()
{
    sudo update-alternatives --config java
    sudo update-alternatives --config javac
    }

ccache()
{
    export USE_CCACHE=1
    prebuilts/misc/linux-x86/ccache/ccache -M 100G
    export CCACHE_COMPRESS=1
    }

Preparebuild()
{
    export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx7G"
    source build/envsetup.sh
    breakfast $device
    }

installclean()
{
    make installclean
    }

clean()
{
    make clean
    }

build()
{
    brunch $device

    }
bootimage()
{
    make bootimage

    }

case $1 in
    -jset)
        JavaSettings
        exit
        ;;
    -markw)
        $(echo markw > $device_file)
        exit
        ;;
    -mido)
        $(echo mido > $device_file)
        exit
        ;;
    -Z00RD)
        $(echo Z00RD > $device_file)
        exit
        ;;
    -cleanall)
        $(echo clean > $cleantype_file)
        exit
        ;;
    -cleaninstall)
        $(echo installclean > $cleantype_file)
        exit
        ;;
    -nonclean)
        $(echo "" > $cleantype_file)
        exit
        ;;
    -bootimg)
        $(echo "bootimage" > $buildtype_file)
        exit
        ;;
    -build)
        $(echo "build" > $buildtype_file)
        exit
        ;;
    -help)
        helpmtd
        exit
        ;;
    --help)
        helpmtd
        exit
        ;;
esac

echo "Current Device: $device


Build Type: $buildtype
Clean Type: $cleantype


Use './build.sh -help' to see script options

BUILD: started

"

#building
ccache
Preparebuild
$cleantype
$buildtype

#kill jack server
./out/host/linux-x86/bin/jack-admin kill-server
