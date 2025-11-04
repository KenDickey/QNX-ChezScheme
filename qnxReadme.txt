### QNX Porting Notes ###
x86-64 -> RasPi4/tarm64le
https://github.com/cisco/ChezScheme
===================================
[Steps]
- build "zou" [native]
   cd zuo
   ./configure && make
   cp zuo ../bin
   cp -r lib ../bin
   cd ..
- source sourceMe.sh
- sh qnxconfig.sh   [=> configure options]
-->> Makefile should have: workarea=tarm64le
- make XM=tarm64le
