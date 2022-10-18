# Aria2 Pro Core

[![LICENSE](https://img.shields.io/github/license/kirbyloco/Aria2-Pro-Core?style=flat-square)](https://github.com/kirbyloco/Aria2-Pro-Core/blob/master/LICENSE)
![GitHub All Releases](https://img.shields.io/github/downloads/kirbyloco/Aria2-Pro-Core/total?label=Downlaods&style=flat-square&color=red)
[![GitHub Stars](https://img.shields.io/github/stars/kirbyloco/Aria2-Pro-Core.svg?style=flat-square&label=Stars&logo=github)](https://github.com/kirbyloco/Aria2-Pro-Core/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/kirbyloco/Aria2-Pro-Core.svg?style=flat-square&label=Forks&logo=github)](https://github.com/kirbyloco/Aria2-Pro-Core/fork)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/kirbyloco/Aria2-Pro-Core/Aria2%20Builder?label=Actions&logo=github&style=flat-square)

Aria2 static binaries for GNU/Linux with some powerful feature patches.

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/kirbyloco/Aria2-Pro-Core?style=for-the-badge)](https://github.com/kirbyloco/Aria2-Pro-Core/releases/latest)

## Changes

* option `max-connection-per-server`: change maximum value to `∞`
* option `min-split-size`: change minimum value to `1K`
* option `piece-length`: change minimum value to `1K`
* download: retry on slow speed (`lowest-speed-limit`) and connection close
* download: add option `retry-on-400` to retry on http 400 bad request, which only effective if `retry-wait` > 0
* download: add option `retry-on-403` to retry on http 403 forbidden, which only effective if `retry-wait` > 0
* download: add option `retry-on-406` to retry on http 406 not acceptable, which only effective if `retry-wait` > 0
* download: add option `retry-on-unknown` to retry on unknown status code, which only effective if `retry-wait` > 0
* Auto Ban Bad Peers: EX. Thunder

## Installing

### Manual installation
```shell
wget https://github.com/kirbyloco/Aria2-Pro-Core/releases/latest/download/aria2-static-linux-amd64.tar.gz
tar zxf aria2-static-linux-amd64.tar.gz
sudo mv aria2c /usr/local/bin
```

### Uninstall
```shell
sudo rm -f /usr/local/bin/aria2c
```

### Aria2

* [Aria2 homepage](https://aria2.github.io/)
* [Aria2 documentation](https://aria2.github.io/manual/en/html/)
* [Aria2 source code (Github)](https://github.com/aria2/aria2)

### Used external libraries

* [zlib_ng](https://github.com/zlib-ng/zlib-ng/)
* [LiberSSL](https://www.libressl.org/)
* [C-Ares](http://c-ares.haxx.se/)
* [SQLite](http://www.sqlite.org/)
* [libSSh2](http://www.libssh2.org/)
* [libXML2](https://gitlab.gnome.org/GNOME/libxml2)

### Credits

* [q3aql/aria2-static-builds](https://github.com/q3aql/aria2-static-builds)
* [myfreeer/aria2-build-msys2](https://github.com/myfreeer/aria2-build-msys2)

## Licence

[![GPLv3](https://www.gnu.org/graphics/gplv3-127x51.png)](https://github.com/P3TERX/Aria2-Pro-Core/blob/master/LICENSE)
