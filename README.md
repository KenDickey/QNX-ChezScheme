# QNX-ChezScheme
Instructions &amp; files to cross-compile Chez Scheme [https://github.com/cisco/ChezScheme] from x86 Linux to QNX 8.0 + Raspberry Pi 4.

Visual Studio Project with QNX plugin.  

Get QNX free licence and directions at  qnx.com/getqnx

Tested on Raspberry Pi 4 + QNX 8.0


This is a quick get-it-working port.  Caveat programmer. If it breaks, you get to keep the pieces.

The good news is that ChezScheme cross bootstraps nicely.

There are a few changes to use QNX 8.0 libraries & includes.
````
# Get the files
cd $HOME
git clone https://github.com/KenDickey/QNX-ChezScheme
# Build zuo x86 native
cd QNX-ChezScheme/zuo
./configure && make
cp zuo ../bin
cp -r lib ../bin
cd ..
# Set the environment
source sourceMe.sh
# Configure
sh ./qnxcondif.sh
# Cross compile for RPi4 arm64
make XM=tarm64le
````
Assuming all went well, you have built `scheme` and `petite` in
subdirectory "tarm64le/bin/tarm64le".

You can check with the `file` command
````
file tarm64le/bin/tarm64le/scheme
````
which should report a ARM aarch64 executable.

You now need to move the required files & libs to the RasPi4 target running QNX.

You can find the inet address via `ifconfig`.  E.g.
````
rpi4qnx:~[==> ifconfig |grep inet
	inet 127.0.0.1 netmask 0xff000000
	inet6 ::1 prefixlen 128
	inet6 fe80::1%lo0 prefixlen 64 scopeid 0x2
	inet6 fe80::dea6:32ff:fe27:62b1%genet0 prefixlen 64 scopeid 0x5
	inet6 fe80::dea6:32ff:fe27:62b4%bcm0 prefixlen 64 scopeid 0x6
	inet 192.168.50.199 netmask 0xffffff00 broadcast 192.168.50.255
rpi4qnx:~[==> bin  # if you have not yet done this..
rpi4qnx:~[==> mkdir lib/csv10.3.0-pre-release.5
````
Shows the inet address to be `192.168.50.199` on the local network.

So on your Linux build machine:
````
scp $HOME/QNX-ChezScheme/tarm64le/bin/tarm64le/* qnxuser@192.168.50.199:/home/qnxuser/bin
scp $HOME/QNX-ChezScheme/tarm64le/boot/tarm64le qnxuser@192.168.50.199:/home/qnxuser/lib//csv10.3.0-pre-release.5
````
Now your `scheme` executable should be able to find the required files.

You can check this using the `--verbose` command option:
````
rpi4qnx:~[==> scheme --verbose
trying /data/home/qnxuser/bin/scheme.boot...cannot open
trying /data/home/qnxuser/bin/../lib/csv10.3.0-pre-release.5/tarm64le/scheme.boot...opened
version and machine type check
trying /data/home/qnxuser/bin/petite.boot...cannot open
trying /data/home/qnxuser/bin/../lib/csv10.3.0-pre-release.5/tarm64le/petite.boot...opened
version and machine type check
Chez Scheme Version 10.3.0-pre-release.5
Copyright 1984-2025 Cisco Systems, Inc.

> (+ 1/2 1/3 1/6)
1
> 
````

Happy, happy! Joy, joy!


Find usage details at https://github.com/cisco/ChezScheme/blob/main/README.md
