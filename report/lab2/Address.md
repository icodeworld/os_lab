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

Actually,variable a represents a storage unit.thus,a mean two value:the address of storage unit and the data of storage unit.So as to clearly point the meaning,**C rules a representing the data of storage unit,and &a representing the address of storage unit.** At the same time,a can not only represent a numerical value,but represent  address of anther storage unit.such as a = 1;a = &b(to store the address of b's storage unit into a's storage unit) .C rules *a represents the data in the storage unit that corresponds to the address(data) stored in a *,that is accessing *a is equal to accessing b.

**summarize**

> (&)		The address of...
>
> (*)		The contents of the address held in..
>
> Another way of saying the second of these is:
>
> ​		The contents of the location pointed to by...
>
> &x		The address at which the variable x is stored
>
> *ptr   	The contents of the variable which is pointed to by ptr

The following example might help to clarify the way in which they are used:

```c
int somevar;			//Declare an int type variable called somevar
int *ptr_to_somevar;	//Declare a pointer to an int type called ptr_to_somevar

somevar = 42; 			//Let somevar take the value 42

prt_to_somevar = &(somevar);//This gives a value to ptr_to_somevar.The value is the address of the variable somevar.Notice that only at this stage does is become a pointer to the particular variable somevar.Before this,its fate is quite open.The declaration merely makes it a pointer which can point to any integer variable which is around

printf("%d",*ptr_to_somevar);//Print out "the contents of the location pointed to by prt_to_somevar"in other words somevar itself.So this will be just 42

*ptr_to_somevar = 56;//Let the contents of the location pointed to by ptr_to_somevar be 56.This is the same as the more direct statement
```

![](D:\Userlist\picture\computer\address2.png)

