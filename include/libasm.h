#ifndef __LIBASM_H__
#define __LIBASM_H__

#include <stddef.h>
#include <sys/types.h>

void *_memset(void *s, int c, size_t n);
void *_memcpy(void *dest, const void *src, size_t n);
void *_memmove(void *dest, const void *src, size_t n);

char *_index(const char *s, int c);
char *_rindex(const char *s, int c);
char *_strchr(const char *s, int c);
char *strstr(const char *haystack, const char *needle);

int _strcmp(const char *s1, const char *s2);
int _strcasecmp(const char *s1, const char *s2);
int _strncmp(const char *s1, const char *s2, size_t n);

size_t _strlen(const char *s);

ssize_t _write(int fd, const void *buf, size_t count);

#endif // __LIBASM_H__