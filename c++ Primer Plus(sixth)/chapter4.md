[TOC]

## Unfamiliar points of knowledge

#### Introducing Arrays

An array declaration should indicate three things:
• The type of value to be stored in each element
• The name of the array
• The number of elements in the array

In particular, arraySize cannot be a variable whose value is set while the program is running. However, later in this chapter you’ll learn how to use the new operator to get around that restriction.

#### Structure declarations

C++ practices discourage the use of external variables but encourage the use of external structure declarations. Also it often makes sense to declare symbolic constants externally.

#### Bit Fields in Structures

The field type should be an integral or enumeration type (enumerations are discussed later in this chapter), and a colon followed by a number indicates the actual number of bits to be used. You can use unnamed fields to provide spacing. Each member is termed a bit field.Here’s an example:

```c++
struct torgle_register
{
    unsigned int SN : 4;   // 4 bits for SN value
    unsigned int : 4;      // 4 bits unused
    bool goodIn : 1;       // valid input (1 bit)
    bool goodTorgle : 1;   // successful torgling
};
```

#### Unions

A union is a data format that can hold different data types but only one type at a time. That is, whereas a structure can hold, say, an int and a long and a double, a union can hold an int or a long or a double. The syntax is like that for a structure, but the meaning is different. For example, consider the following declaration:

```c++
union one4all
{
    int int_val;
    long long_val;
    double double_val;
};
```



Because a union holds only one value at a time, it has to have space enough to hold its largest member. Hence, the size of the union is the size of its largest member.
One use for a union is to save space when a data item can use two or more formats but never simultaneously.

```c++
struct widget 
{
    char brand[20];
    int type;
    union id	// format depends on widget type
    {
        long id_num;	// type 1 widgets
        char id_char[20];	// other widgets
    } id_val;
};
...
widget prize;
...
if (prize.type == 1)
	cin >> prize.id_val.id_num;	// use member name to indicate mode
else
	cin >> prize.id_val.id_char;
```

```c++
struct widget
{
    char brand[20];
    int type;
    union			// anonymous union
    {
        long id_num;
        char id_char[20];
    };
};
...
widget prize;
...
if (prize.type == 1) 
	cin >> prize.id_num;
else 
	cin >> prize.id_char;
```

#### Enumerations

```c++
enum spectrum {red, orange, yellow, green, blue, violet, indigo, ultraviolet};
```

This statement does two things:

-  It makes spectrum the name of a new type; spectrum is termed an enumeration, much as a struct variable is called a structure.
-  It establishes red, orange, yellow, and so on, as symbolic constants for the integer values 0–7. These constants are called enumerators.

#### Pointer

C++ uses the context to determine whether you mean multiplication or dereferencing.) Suppose, for example, that manly is a pointer. In that case, manly represents an address, and *manly represents the value at that address. The combination *manly becomes equivalent to an ordinary type int variable. Listing 4.15 demonstrates these ideas. It also shows how to declare a pointer.

```c++
#include <iostream>
int main()
{
	using namespace std;
	int updates = 6;    // declare a variable
	int * p_updates;    // declare pointer to an int
	p_updates = &updates;  // assign address of int to pointer
	// express values two ways
	cout << "Values: updates = " << updates;
	cout << ", *p_updates = " << *p_updates << endl;
	// express address two ways
	cout << "Addresses: &updates = " << &updates;
	cout << ", p_updates = " << p_updates << endl;

// use pointer to change value
    *p_updates = *p_updates + 1;
    cout << "Now updates = " << updates << endl;
    return 0;
}
```

![1540815032031](E:\icodeworld.github.io\os_lab\c++ Primer Plus(sixth)\assets\1540815032031.png)

```c++
// init_ptr.cpp -- initialize a pointer
#include <iostream>
int main()
{
	using namespace std;
	int higgens = 5;
	int * pt = &higgens;
	
	cout << "Value of higgens = " << higgens
		 << "; Address of higgens = " << &higgens << endl;
	cout << "Value of *pt = " << *pt
		 << "; Value of pt = " << pt << endl;
	return 0;
}
```

![1540815876962](E:\icodeworld.github.io\os_lab\c++ Primer Plus(sixth)\assets\1540815876962.png)

Pointer Golden Rule: Always initialize a pointer to a definite and appropriate address before you apply the dereferencing operator (*) to it.

#### New and Delete

If you want to use a numeric value as an address, you should use a type cast to convert the number to the appropriate address type:

```C++
int * pt;
pt = (int *) 0xB8000000; // types now match
```

`int * pn = new int;`

The new int part tells the program you want some new storage suitable for holding an int. The new operator uses the type to figure out how many bytes are needed. Then it finds the memory and returns the address. Next, you assign the address to pn, which is declared to be of type pointer-to-int. Now pn is the address and *pn is the value stored there.

The general form for obtaining and assigning memory for a single data object, which can be a structure as well as a fundamental type, is this:

`typeName * pointer_name = new typeName;`

Another point to note is that typically new uses a different block of memory than do the ordinary variable definitions that we have been using. Both the variables nights and pd have their values stored in a memory region called the stack, whereas the memory allocated by new is in a region called the heap or free store.

You should use delete only to free memory allocated with new. However, it is safe to apply delete to a null pointer.

```c++
int * ps = new int;   // ok
delete ps;            // ok
delete ps;            // not ok now
int jugs = 5;         // ok
int * pi = &jugs;     // ok
delete pi;            // not allowed, memory not allocated by new
```

• Use delete [] if you used new [] to allocate an array.
• Use delete (no brackets) if you used new to allocate a single entity.
• It’s safe to apply delete to the null pointer (nothing happens).

The general form for allocating and assigning memory for an array is this:
`type_name * pointer_name = new type_name [num_elements];`

```c++
short tell[10];        // tell an array of 20 bytes
cout << tell << endl;  // displays &tell[0]
cout << &tell << endl; // displays address of whole array
```

```c++
int tacos[10] = {5,2,8,4,1,2,2,4,6,8};
int * pt = tacos;       // suppose pf and tacos are the address 3000
pt = pt + 1;            // now pt is 3004 if a int is 4 bytes
int *pe = &tacos[9];    // pe is 3036 if an int is 4 bytes
pe = pe - 1;            // now pe is 3032, the address of tacos[8]
```

#### Pointer cast

Normally, if you give cout a pointer, it prints an address. But if the pointer is type char *, cout displays the pointed-to string. If you want to see the address of the string, you have to type cast the pointer to another pointer type, such as int *, which this code does. So ps displays as the string "fox", but (int *) ps displays as the address where the string is found. Note that assigning animal to ps does not copy the string; it copies the address. This results in two pointers (animal and ps) to the same memory location and string.

#### Array

The name of an array is the address of its first element

Often you encounter the need to place a string into an array. You use the `=` operator when you initialize an array; otherwise, you use strcpy() or strncpy(). You’ve seen the strcpy() function; it works like this:
`char food[20] = "carrots"; // initialization`
`strcpy(food, "flan");      // otherwise`

```c++
strcpy(food, "a picnic basket filled with many goodies");


strncpy(food, "a picnic basket filled with many goodies", 19);
food[19] = '\0';
```

Use strcpy() or strncpy(), not the assignment operator, to assign a string to an array.

#### Dynamic Structures 

Sometimes new C++ users become confused about when to use the dot operator and when to use the arrow operator to specify a structure member. The rule is simple: If the structure identifier is the name of a structure, use the dot operator. If the identifier is a pointer to the structure, use the arrow operator.

## Chapter Review

> 1. How would you declare each of the following?
>   a. actors is an array of 30 char.
>   b. betsie is an array of 100 short.
>   c. chuck is an array of 13 float.
>   d. dipsea is an array of 64 long double.
>
> 2. Does Chapter Review Question 1 use the array template class instead of built-in arrays.
>
> 3. Declare an array of five ints and initialize it to the first five odd positive integers.
>
> 4. Write a statement that assigns the sum of the first and last elements of the array in Question 3 to the variable even.
>
> 5. Write a statement that displays the value of the second element in the float array ideas.
>
> 6. Declare an array of char and initialize it to the string "cheeseburger".
>
> 7. Declare a string object and initialize it to the string "Waldorf Salad".
>
> 8. Devise a structure declaration that describes a fish. The structure should include the kind, the weight in whole ounces, and the length in fractional inches.
>
> 9. Declare a variable of the type defined in Question 8 and initialize it.
>
> 10. Use enum to define a type called Response with the possible values Yes, No, and Maybe. Yes should be 1, No should be 0, and Maybe should be 2.
>
> 11. Suppose ted is a double variable. Declare a pointer that points to ted and use the pointer to display ted’s value.
>
> 12. Suppose treacle is an array of 10 floats. Declare a pointer that points to the first element of treacle and use the pointer to display the first and last elements of the array.
>
> 13. Write a code fragment that asks the user to enter a positive integer and then creates a dynamic array of that many ints. Do this by using new, then again using a vector object.
>
> 14. Is the following valid code? If so, what does it print?
>     cout << (int *) "Home of the jolly bytes";
>
> 15. Write a code fragment that dynamically allocates a structure of the type described in Question 8 and then reads a value for the kind member of the structure.
> 16. Listing 4.6 illustrates a problem created by following numeric input with line-oriented string input. How would replacing this:
>     cin.getline(address,80);
>
>     with this:
>     cin >> address;
>
>     affect the working of this program?
>
> 17. Declare a vector object of 10 string objects and an array object of 10 string objects. Show the necessary header files and don’t use using. Do use a const for the number of strings.

### Answer

1. Declare in built-in array

   ```c++
   char actors[30];
   short betsie[100];
   float chuck[13];
   long double dipsea[64];
   ```

2. Declare in array template

   ```c++
   array<char, 30> actors;
   array<short, 100> betsie;
   array<float, 13> chuck;
   array<long double, 64> dipsea;
   ```

3. `int oddly[5] = {1, 3, 5, 7, 9};`

4. `int even = oddly[0] + oddly[4];`

5. `std::cout << ideas[1] <<endl;`

6. ```c++
   char lunch[13] = "cheesebuger";	// number of character +1
   or
   char lunch[] = "cheeseburger";	// let the compiler count elements
   ```

7. `std::string lunch = "Waldorf Salad";`

8. ```c++
   struct fish
   {
        char kind[20];
        int weight;
        float length;
   };
   ```

9. ```c++
   fish petes = 
   {
       "trout",
       12,
       22.22
   };
   ```

10. `enum Response = {No, Yes, Maybe};`

11. `double * pt = &ted; cout << *pt << endl;`

12. ```c++
    float * pt = treacle; // or = &treacle[0]
    cout << *pt << endl << pt[9] << endl;
    // or use *pt and *(pf +9)
    ```

13. ```
    // array
    cin >> 
    
    
    
    
    
    
    ```
