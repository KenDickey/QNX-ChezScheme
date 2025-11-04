#!/bin/bash
# This script sets environment variables required to use this version of QNX Software Development Platform
# from the command line. To use the script, you have to "source" it into your shell, i.e.:
#    source sourceMe.sh
# if source command is not available use "." (dot) command instead
#
test "$BASH_SOURCE" = "" && echo "This script can be sourced only from bash" && return
SCRIPT_SOURCE=$BASH_SOURCE
test "$SCRIPT_SOURCE" = "$0" && echo "Script is being run, should be sourced" && exit 1

## Raspberry Pi 4 + QNX ## 
export QNX_PLATFORM=aarch64le
export QNX_SDP_VERSION=qnx800
export QNX_BASE=$HOME/$QNX_SDP_VERSION
export QNX_TARGET=$QNX_BASE/target/qnx/aarch64le

HOST_OS=$(uname -s)
case "$HOST_OS" in
	Linux)
    QNX_HOST=$QNX_BASE/host/linux/x86_64
		;;
	*)
    QNX_HOST=$QNX_BASE/host/win64/x86_64
		;;
esac

##export QNX_TARGET=$QNX_BASE/target/qnx
export QNX_CONFIGURATION_EXCLUSIVE=$HOME/.qnx
export QNX_CONFIGURATION=$QNX_CONFIGURATION_EXCLUSIVE

export SWCENTER_INSTALL_PATH=$HOME/qnx/qnxsoftwarecenter
export QSC_CLT_PATH=$SWCENTER_INSTALL_PATH/qnxsoftwarecenter_cltw
export QNX_PROJECTS=$HOME/qnx/qnxprojects
export QNX_CONFIGURATION_EXCLUSIVE=$HOME/.qnx
export QNX_CONFIGURATION=$QNX_CONFIGURATION_EXCLUSIVE
export QNX_CC="qcc -Vgcc_ntoaarch64le"
export QNX_CCFLAGS="-I$QNX_BASE/target/qnx/usr/include"
export QNX_CFLAGS=$QNX_CCFLAGS
export QNX_MAKEFLAGS=$QNX_CCFLAGS
export QNX_LDFLAGS="-L$QNX_TARGET/lib -L$QNX_TARGET/usr/lib"
export QNX_CPU=aarch64
export QNX_TARGET_OS=qnx
export QNX_TARGET_ARCH=-Vgcc_ntoaarch64le

## Add access to QNX tools
export PATH=$QNX_HOST/usr/bin:$QNX_CONFIGURATION/bin:$QNX_BASE/jre/bin:$QNX_BASE/host/common/bin:$PATH

### --- E O F --- ###
