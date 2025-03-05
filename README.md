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
    struct node *left;  # +0
    struct node *right; # +8
    int nodetype;       # +16
    void *value;        # +24
};
sizeof(struct node) = 32;
```

| nodeType     | type number | value            |
| ------------ | ----------- | ---------------- |
| return       | 1           | return code      |
| int function | 2           | name of function |
