This is sqlite3-pcre, an extension for sqlite3 that uses libpcre to provide
the REGEXP() function.

The code was written by Alexey Tourbin and can be found at:

http://git.altlinux.org/people/at/packages/?p=sqlite3-pcre.git

The build system has been changed from make to CMake + make.
The libraries `sqlite3` and `pcre` are prerequisites.

Run

```
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_PATH ..
make
```

to build the extension in the build directory.

Run `make install` to place the extension into `$INSTALL_PATH`.
