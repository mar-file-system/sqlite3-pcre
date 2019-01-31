VERSION=0.1.1
CC=cc
INSTALL=install
CFLAGS=$(shell pkg-config --cflags sqlite3 libpcre) -fPIC
LIBS=$(shell pkg-config --libs libpcre)
prefix =? /usr

OS=$(shell uname -s)
ifeq ($(OS),Darwin)
     LDFLAGS += -Wl,-undefined,error
     INFLAGS += -S
else
     LDFLAGS += -Wl,-z,defs
     INFLAGS += -pD
endif


.PHONY : install dist clean

pcre.so : pcre.c
	${CC} -shared -o $@ ${CFLAGS} -W -Werror pcre.c ${LIBS} $(LDFLAGS)

install : pcre.so
ifeq ($(OS),Darwin)
	mkdir -p ${DESTDIR}${prefix}/lib/sqlite3
endif
	${INSTALL} $(INFLAGS) -m755 pcre.so ${DESTDIR}${prefix}/lib/sqlite3/pcre.so

dist : clean
	mkdir sqlite3-pcre-${VERSION}
	cp -f pcre.c Makefile readme.txt sqlite3-pcre-${VERSION}
	tar -czf sqlite3-pcre-${VERSION}.tar.gz sqlite3-pcre-${VERSION}

clean :
	-rm -f pcre.so
