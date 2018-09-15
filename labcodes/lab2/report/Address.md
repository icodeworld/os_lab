

# the understanding of * and &：

test

```C
#include <iostream> 
using namespace std;
int main() {
    int a = 20;
    int *b = &a;
    cout<<a<<" ";
    cout<<&a<<" ";
    cout<<b<<" ";
    cout<<*b<<" ";
}

result： 
20 0x70fe44 0x70fe44 20
```

Actually,variable a represents a storage unit.thus,a mean two value:the address of storage unit and the data of storage unit.So as to clearly point the meaning,**C rules a representing the data of storage unit,and &a representing the address of storage unit.** At the same time,a can not only represent a numerical value,but represent  address of anther storage unit.such as a = 1;a = &b(to store the address of b's storage unit into a's storage unit) .**C rules *a represents the data in the storage unit that corresponds to the address(data) stored in a ***,that is accessing *a is equal to accessing b.

summarize

**a represents the content of stored in storage unit a**

<u>&a represents the address of stored in storage unit a</u>

<u>*a 1.Requires that the data in a corresponding storage unit must be the address of another storage unit   2. *a represents the data of another storage unit</u>

When the type of a declaration is int, the value stored in a is an integer value that can be accessed (read or modified) by a. 
when the type of a declaration is int*, the address of a storage unit is stored in a, and the data stored in the storage unit is an integer value, which can be accessed (read or modified) by *a.

A == &*a is the address of the storage unit.
when the type of a declaration is int**, the address of a storage unit is stored in a, and the data stored in the storage unit is the address of another storage unit, and this storage unit stores an integer value, which can be accessed (read or modified) by **a.