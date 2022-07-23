# lebu
A programming language for everything. Binod is a programming language that is simple yet very powerful. Using binod one can write baremetal programmes such as kernel, webservers to and less list.

### Variable Declaration 
Binod has auto static typecasting i.e it automatically detects the data type and assigns to it. For example
```
x = 100;
```
This is assumed as
```rust
int x = 100;
```

### Data types
Lebu has 4 data types i.e integer `int`, float `float`, string `str` and array `arr`

#### Integers
Integers are 2 byte or 4 byte values depending upon your system and compiler you use.

```
int x = 100;
```
#### Float
Floats are data types for decimal value.
```
float pi = 3.14;
```
#### Strings
Strings are char pointers i.e `char*` they are immutable
```
str string = "Hello"
```

#### Array
Array is same as that of array in objective-C
```
arr x = [1,2,3];
```


### Arathmatic Operation 
```
3+5
7-5
4*3
10/2
(3+7)*28
```


#### Comparision 
```
2 == 2
3 != 5
5 > 3
2 < 4
5 >= 4
8 <= 2
```

### loops
#### while loop
```
while x == 10 {
    // code 
}
```

##### for loop
```
for i in 1 .. 2 {
  // Code
}
```

### Object Orientation
```js
class Duck {
  str name;
  int size;

  func _init(name, size) {
    this.name = name;
    this.size = size;
  }

  func quack() {
  }
}

duck = Duck("Lichi", 10);
duck.quack();

```

Object orientation has been very controversial topic among programmers, it helps programmers to deal with similar structured data but also brings complexities along with it. Lichi deals with this problem by emulating obejct orientation using structs, hence the objects are just structs and can be used by external functions.

