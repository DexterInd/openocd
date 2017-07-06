#! /bin/bash
#####################################################################
#
# to install:
# curl --silent https://raw.githubusercontent.com/DexterInd/openocd/master/openocd_install.sh | bash
#
#####################################################################

PIHOME=/home/pi
DEXTER=Dexter
LIB=lib
OPENOCD=openocd

pushd $PIHOME > /dev/null
result=${PWD##*/} 
# check if ~/Dexter exists, if not create it
if [ ! -d $DEXTER ] ; then
    mkdir $DEXTER
fi
# go into $DEXTER
cd $DEXTER


# check if /home/pi/Dexter/lib exists, if not create it
if [ ! -d $LIB ] ; then
    mkdir $LIB
fi
cd $LIB


# check if /home/pi/Dexter/lib/openocd exists
# if not, clone the folder
# if yes, refresh the folder
if [ ! -d $OPENOCD ] ; then
    # clone the folder
    sudo git clone --quiet https://github.com/DexterInd/openocd.git
    cd $OPENOCD
else
    cd $OPENOCD
    sudo git pull --quiet
fi


# unzip the compiled OpenOCD
sudo unzip openocd_compiled.zip

# Put the configuration files into /usr/local/share
sudo cp -rn openocd_compiled/files/openocd /usr/local/share

# Put the openocd binary into /usr/bin
sudo cp -rn openocd_compiled/openocd /usr/bin

# Make the openocd binary executable
sudo chmod +x /usr/bin/openocd

# Remove the unzipped files
rm -rf openocd_compiled

popd > /dev/null
