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

- fix ';' not split
  `$r11 : 0x00007ffff7ff7028 → 0x00007ffff7ff2008 → 0x0000000a7d003b30 ("0;"?)`
