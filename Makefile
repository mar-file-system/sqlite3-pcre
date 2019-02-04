VERSION=0.1.1
CC?=cc
CFLAGS=$(shell pkg-config --cflags sqlite3 libpcre)
LIBS=$(shell pkg-config --libs sqlite3 libpcre)
AR=ar
INSTALL=install
prefix =? /usr

OS=$(shell uname -s)
ifeq ($(OS),Darwin)
     LDFLAGS += -Wl,-undefined,error
     INFLAGS += -S
     SHARED_EXT = dylib
else
     LDFLAGS += -Wl,-z,defs
     INFLAGS += -pD
     SHARED_EXT = so
endif

TARGETS=libpcre.${SHARED_EXT} libpcre.a

.PHONY : install dist clean

all: ${TARGETS}

libpcre.${SHARED_EXT} : pcre.c
	${CC} -shared -o $@ ${CFLAGS} -fPIC -W -Werror $< ${LIBS} $(LDFLAGS)

libpcre.a : pcre.c
	${CC} -static -o $@ ${CFLAGS} -c -W -Werror $< ${LIBS} $(LDFLAGS) -DSQLITE_CORE

install : ${TARGETS}
ifeq ($(OS),Darwin)
	mkdir -p ${DESTDIR}${prefix}/lib/sqlite3
endif
	${INSTALL} $(INFLAGS) -m755 libpcre.${SHARED_EXT} ${DESTDIR}${prefix}/lib/sqlite3/libpcre.${SHARED_EXT}
	${INSTALL} $(INFLAGS) -m755 libpcre.a ${DESTDIR}${prefix}/lib/sqlite3/libpcre.a

dist : clean
	mkdir sqlite3-pcre-${VERSION}
	cp -f pcre.c Makefile readme.txt sqlite3-pcre-${VERSION}
	tar -czf sqlite3-pcre-${VERSION}.tar.gz sqlite3-pcre-${VERSION}

clean :
	-rm -f ${TARGETS}
