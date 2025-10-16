# QNX-ChezScheme
Instructions &amp; files to cross-compile Chez Scheme [https://github.com/cisco/ChezScheme] to QNX/RPi4

This is a work-in-progress to create a QNX Port to be placed in https://github.com/qnx-ports/build-files

In the mean time, if you can't wait to get ChezScheme up on QNX, the basic process is:

````
git clone https://github.com/cisco/ChezScheme
````
Get free QNX license and SDP: https://www.qnx.com/products/evaluation/

- invoke qnxconfig.sh [=> configure options]
- source ~/qnx800/qnxsdp-env.sh
- cd ChezScheme
- build "zou" [native]
- build "LX4" [cross]
- make XM=tarm64le


````
vvv======vvv qnxconfig.sh
./configure --cross --machine=tarm64le --os=tarm64le  CC_FOR_BUILD="$QNX_CC" CFLAGS_FOR_BUILD="$QNX_CFLAGS" --disable-x11 CC="$QNX_CC" CFLAGS="-arch arm64 $QNX_CFLAGS" LDFLAGS="$QNX_LDFLAGS" ZLIB="$HOME/qnx800/target/qnx/aarch64le/usr/lib/libz.so" LZ4="/home/kend/ChezScheme/tarm64le/lz4/lib/liblz4.so"
^^^======^^^
````
