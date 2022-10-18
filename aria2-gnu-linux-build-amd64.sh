SCRIPT_DIR=$(dirname $(readlink -f $0))

## CONFIG ##
BUILD_DIR="/tmp"
ARIA2_CODE_DIR="$BUILD_DIR/aria2"
OUTPUT_DIR="$BUILD_DIR/output"
PREFIX="$BUILD_DIR/aria2-build-libs"
export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig"
export LD_LIBRARY_PATH="$PREFIX/lib"
export CC="gcc"
export CXX="g++"
export STRIP="strip"
export RANLIB="ranlib"
export AR="ar"
export LD="ld"

## DEPENDENCES ##
ZLIB_NG='https://github.com/zlib-ng/zlib-ng/archive/refs/tags/2.0.6.tar.gz'
C_ARES='https://c-ares.haxx.se/download/c-ares-1.18.1.tar.gz'
LIBRESSL='https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.5.3.tar.gz'
SQLITE3='https://www.sqlite.org/2022/sqlite-autoconf-3390400.tar.gz'
LIBSSH2='https://github.com/libssh2/libssh2/archive/refs/heads/master.tar.gz'
LIBXML2='https://github.com/GNOME/libxml2/archive/refs/tags/v2.10.3.tar.gz'

apt update
apt -y install build-essential git curl \
    libcppunit-dev autoconf automake autotools-dev autopoint libtool pkg-config

ZLIB_NG_BUILD() {
    mkdir -p $BUILD_DIR/zlib_ng && cd $BUILD_DIR/zlib_ng
    curl -Ls -o - "$ZLIB_NG" | tar -zxf - --strip-components=1
    ./configure \
        --prefix=$PREFIX \
        --static \
        --zlib-compat
    make -j$(nproc)
    make install
}

C_ARES_BUILD() {
    mkdir -p $BUILD_DIR/c-ares && cd $BUILD_DIR/c-ares
    curl -Ls -o - "$C_ARES" | tar -zxf - --strip-components=1
    ./configure \
        --prefix=$PREFIX \
        --enable-static \
        --disable-shared \
        --enable-silent-rules \
        --disable-tests
    make -j$(nproc)
    make install
}

LIBRESSL_BUILD() {
    mkdir -p $BUILD_DIR/libressl && cd $BUILD_DIR/libressl
    curl -Ls -o - "$LIBRESSL" | tar -zxf - --strip-components=1
    autoreconf
    ./configure \
        --prefix=$PREFIX \
        --enable-silent-rules \
        --enable-static \
        --disable-shared \
        --with-openssldir=/etc/ssl
    make -j$(nproc)
    make install_sw
}

SQLITE3_BUILD() {
    mkdir -p $BUILD_DIR/sqlite3 && cd $BUILD_DIR/sqlite3
    curl -Ls -o - "$SQLITE3" | tar -zxf - --strip-components=1
    ./configure \
        --prefix=$PREFIX \
        --enable-static \
        --disable-shared
    make -j$(nproc)
    make install
}

LIBSSH2_BUILD() {
    mkdir -p $BUILD_DIR/libssh2 && cd $BUILD_DIR/libssh2
    curl -Ls -o - "$LIBSSH2" | tar -zxf - --strip-components=1
    autoreconf -if -Wall
    ./configure \
        --prefix=$PREFIX \
        --enable-static \
        --disable-shared \
        --enable-silent-rules
    make -j$(nproc)
    make install
}

LIBXML2_BUILD() {
    mkdir -p $BUILD_DIR/libxml2 && cd $BUILD_DIR/libxml2
    curl -Ls -o - "$LIBXML2" | tar -zxf - --strip-components=1
    autoreconf -if -Wall
    ./configure \
        --prefix=$PREFIX \
        --enable-silent-rules \
        --without-python \
        --without-icu \
        --enable-static \
        --disable-shared
    make -j$(nproc)
    make install
}

ARIA2_BUILD() {
    git clone https://github.com/aria2/aria2 $ARIA2_CODE_DIR
    cd $ARIA2_CODE_DIR
    git apply $SCRIPT_DIR/patch/*.patch
    autoreconf -if -Wall
    ./configure \
        --prefix=$PREFIX \
        --disable-shared \
        ARIA2_STATIC=yes
    make -j$(nproc)
}



## BUILD PROCESS ##
ZLIB_NG_BUILD
LIBRESSL_BUILD
LIBXML2_BUILD
SQLITE3_BUILD
C_ARES_BUILD
LIBSSH2_BUILD
ARIA2_BUILD

cd $ARIA2_CODE_DIR/src
$STRIP aria2c
mkdir $OUTPUT_DIR
tar zcf $OUTPUT_DIR/aria2-static-linux-amd64.tar.gz aria2c

echo "finished!"
