# char allow

- 0x09
- 0x11 to 0x13
- 0x20 to 0x23
- 0x25 to 0x3F
- 0x41 to 0x5F
- 0x61 to 0x7E

# [C Keyword](https://en.cppreference.com/w/c/keyword)

auto
break
case
char
const
continue
default
do
double
else
enum
extern
float
for
goto
if
inline (C99)
int
long
register
restrict (C99)
return
short
signed
sizeof
static
struct
switch
typedef
union
unsigned
void
volatile
while

# C Preprocessor Keyword

if
elif
else
endif

ifdef
ifndef
define
undef

include
line
error
pragma

defined

# AST

```c
struct node {
    struct node *parent # +0
    struct node *left;  # +8
    struct node *right; # +16
    int nodetype;       # +24
    void *value;        # +32
};
sizeof(struct node) = 40;
```

| nodeType | type number | value            | is ptr |
| -------- | ----------- | ---------------- | ------ |
| return   | 1           | return code      | [ ]    |
| function | 2           | name of function | [x]    |
| int      | 4           | not a node type  | [ ]    |

# Link elf using ld

```sh
ld -o a.out /lib/crt1.o /lib/crti.o /lib/crtn.o -lc simpleMain.o --dynamic-linker /lib64/ld-linux-x86-64.so.2
```

# TODO

- test if end of expression if ';'

# open syscall

## File Access Modes

- O_RDONLY: 0 (0000 in octal)
- O_WRONLY: 1 (0001 in octal)
- O_RDWR: 2 (0002 in octal)

## File Creation and Status Flags

- O_CREAT: 64 (0100 in octal)
- O_EXCL: 128 (0200 in octal)
- O_NOCTTY: 256 (0400 in octal)
- O_TRUNC: 512 (01000 in octal)

## File Status Flags

- O_APPEND: 1024 (02000 in octal)
- O_ASYNC: 8192 (020000 in octal)
- O_DIRECT: 16384 (040000 in octal)
- O_DIRECTORY: 65536 (0200000 in octal)
- O_NOATIME: 262144 (01000000 in octal)
- O_NOFOLLOW: 131072 (0400000 in octal)
- O_NONBLOCK or O_NDELAY: 2048 (04000 in octal)
- O_SYNC: 129024 (04010000 in octal)
- O_DSYNC: 4096 (010000 in octal)
- O_RSYNC: 1052672 (04010000 in octal)
- O_CLOEXEC: 524288 (02000000 in octal)
- O_TMPFILE: 4294967296 (010000000000 in octal)
