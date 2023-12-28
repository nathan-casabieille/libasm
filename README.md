# libasm
some C standard library functions recoded in x86_64 NASM Assembly

# Implemented functions
| Function | Prototype | Status
|       ---       |       ---       |      ---       |
| **memcpy** | `void *_memcpy(void *dest, const void *src, size_t n);` |✅ tested |
| **memset** | `void *_memset(void *s, int c, size_t n);` |✅ tested |
| **index** | `char *index(const char *s, int c);` |✅ tested |
| **rindex** | `char *_rindex(const char *s, int c);` |✅ tested |
| **strstr** | `char *strstr(const char *haystack, const char *needle);` |✅ tested |
| **strcmp** | `int _strcmp(const char *s1, const char *s2);` |✅ tested |
| **strncmp** | `int _strncmp(const char *s1, const char *s2, size_t n);` |✅ tested |
| **strcasecmp** | `int _strcasecmp(const char *s1, const char *s2);` |✅ tested |
| **strlen** | `size_t _strlen(const char *s);` |✅ tested |
| **write** | `ssize_t _write(int fd, const void *buf, size_t count);` |✅ tested |


# How to use it in your C projects

## Introduction

## Compilation
To compile the library, if you're on a UNIX-like system (including Linux and macOS), it could be as easy as typing

```
make
```

The library (libasm.so) is compiled as a dynamic library. To use it in your C projects, you need to compile your code with the following flags:

```
gcc main.c -L. -lasm
```

## Unit Testing

Each function in libasm is rigorously tested using the Unity testing framework (Unity.h).

### Running Unit Tests

To run the unit tests for libasm and verify that all functions perform as expected, follow these steps:

2. Navigate to the project directory containing the libasm source code and the Makefile.

3. Open a terminal and enter the following command:

```
   make test
```
