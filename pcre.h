#ifndef SQLITE3_PCRE_H
#define SQLITE3_PCRE_H

#include <sqlite3.h>

int sqlite3_extension_init(sqlite3 *db, char **err, const sqlite3_api_routines *api);

#endif
