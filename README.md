# QNX-ChezScheme
Instructions &amp; files to cross-compile Chez Scheme [https://github.com/cisco/ChezScheme] to QNX/RPi4

This is a work-in-progress to create a QNX Port to be placed in https://github.com/qnx-ports/build-files

In the mean time, if you can't wait to get ChezScheme up on QNX, the basic process is:

````
git clone --filter=blob:none https://github.com/cisco/ChezScheme
````
Get free QNX license and SDP: https://www.qnx.com/products/evaluation/

- invoke qnxconfig.sh [=> configure options]
- source ~/qnx800/qnxsdp-env.sh
- cd ChezScheme
- build "zou" [native x86]
- build "LX4" [cross aarch64/arm64le]
- make XM=tarm64le
- as qnxuser on target
  - mkdir chezbin chezlib
- copy built files to target
  - scp -r tarm64le/bin/tarmle qnxuser@192.168.50.`where`:/home/qnxuser/chezbin
  - scp -r tarm64le/boot/tarmle qnxuser@192.168.50.`where`:/home/qnxuser/chezlib
  - scp -r examples qnxuser@192.168.50.<where>:/home/qnxuser/chezlib
- on target [as root]
  - mv chezlib /usr/local/csv10.3.0-pre-release.5  # use version-name
  - mv chezbin/tarm64le/* /usr/bin     # scheme, petite

````
vvv======vvv qnxconfig.sh
./configure --cross --machine=tarm64le --os=tarm64le  CC_FOR_BUILD="$QNX_CC" CFLAGS_FOR_BUILD="$QNX_CFLAGS" --disable-x11 CC="$QNX_CC" CFLAGS="-arch arm64 $QNX_CFLAGS" LDFLAGS="$QNX_LDFLAGS" ZLIB="$HOME/qnx800/target/qnx/aarch64le/usr/lib/libz.so" LZ4="$HOME/ChezScheme/tarm64le/lz4/lib/liblz4.so"
^^^======^^^
````
Where .bashrc has:
````
QNX_BASE="$HOME/qnx800"
QNX_CC=qcc -Vgcc_ntoaarch64le
QNX_CFLAGS="-I$HOME/qnx800/target/qnx/usr/include -L$HOME/qnx800/target/qnx/aarch64le/lib -L$HOME/qnx800/target/qnx/aarch64le/usr/lib"
````
