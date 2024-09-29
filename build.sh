cdir=$(pwd)
mkdir SDK
export _target=sh3eb-elf
cd binutils*
mkdir build
cd build
../configure --target=${_target} \
    --prefix=${cdir}/SDK \
    --program-prefix=${_target}- \
    --disable-werror \
    --enable-cet \
    --enable-colored-disassembly \
    --enable-default-execstack=no \
    --enable-deterministic-archives \
    --enable-gold \
    --enable-jansson \
    --enable-ld=default \
    --enable-new-dtags \
    --enable-plugins \
    --enable-relro \
    --enable-shared \
    --enable-threads \
    --enable-gdb \
    --enable-gdbserver \
    --disable-libdecnumber \
    --disable-readline \
    --disable-sim \
    --disable-werror \
    --with-debuginfod \
    --with-pic \
    --with-system-zlib
make configure-host
make
make install
cd ../..
cd gcc*
mkdir build
cd build
../configure \
    --prefix= ${cdir}/SDK \
    --program-prefix=${_target}- \
    --target=${_target} \
    --disable-shared \
    --disable-nls \
    --disable-tls \
    --disable-threads \
    --enable-languages=c,c++ \
    --enable-multilib \
    --with-system-zlib \
    --with-local-prefix=${cdir}/SDK/${_target} \
    --with-as=${cdir}/SDK/bin/${_target}-as \
    --with-ld=${cdir}/SDK/bin/${_target}-ld \
    --disable-libgomp \
    --enable-interwork \
    --enable-addons \
    --enable-sjlj-exceptions \
    --disable-hosted-libstdcxx \
    --with-gnu-as \
    --with-gnu-ld \
    --disable-libssp \
    --disable-__cxa_atexit \
    --enable-ltupport \
    --libdir=${cdir}/SDK/lib \
    --libexecdir=${cdir}/SDK/lib \
    --enable-lto
make all-gcc all-target-libgcc
make install-strip-gcc install-strip-target-libgcc
cd ../..
cd mkg3a*
cmake . -B build -DCMAKE_INSTALL_PREFIX=${cdir}/SDK
cd build
make
make install
cd ../..
cd libfxcg*
export PATH=${cdir}/SDK/bin:$PATH
make
cp -r include ${cdir}/SDK
cp -r lib ${cdir}/SDK
