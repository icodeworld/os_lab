[TOC]

##  Knowledge

##### Function

• Provide a function definition
• Provide a function prototype
• Call the function

##### Parameter and argument

parameter don't influence the value of argument

The main difference between the formal parameters and the other local variables is that the formal parameters get their values from the function that calls probability(), whereas the other variables get values from within the function.

##### array

It turns out that both headers are correct because in C++ the notations int `*arr` and int `arr[]` have the identical meaning when (and only when) used in a function header or function prototype. Both mean that `arr` is a pointer-to-int. However, the array notation version (`int arr[])` symbolically reminds you that `arr` not only points to an int, it points to the first int in an array of `ints`. This book uses the array notation when the pointer is to the first element of an array, and it uses the pointer notation when the pointer is to an isolated value. Remember that the notations int `*arr` and int `arr[]` are not synonymous in any other context. For example, you can’t use the notation int tip[] to declare a pointer in the body of a function.

If you pass an ordinary variable, the function works with a copy. But if you pass an array, the function works with the original. Actually, this difference doesn’t violate C++’s pass-by-value approach.

##### Pointers and `const`

Using `const` with pointers has some subtle aspects (pointers always seem to have subtle aspects), so let’s take a closer look. You can use the const keyword two different ways with pointers. The first way is to make a pointer point to a `constant` object, and that prevents you from using the pointer to change the pointed-to value. The second way is to make the pointer itself `constant`, and that prevents you from changing where the pointer points.

##### Using const When You Can

There are two strong reasons to declare pointer arguments as pointers to constant data:

• It protects you against programming errors that inadvertently alter data.
• Using const allows a function to process both const and non-const actual arguments, whereas a function that omits const in the prototype can accept only non-const data.
You should declare formal pointer arguments as pointers to const whenever it’s appropriate to do so.

```c++
int sloth = 3;
const int * ps = &sloth;	// a pointer to const int 
int * const finger = &sloth;	// a const pointer to int
```

Note that the last declaration has repositioned the keyword const. This form of declaration constrains finger to point only to sloth. However, it allows you to use finger to alter the value of sloth. The middle declaration does not allow you to use ps to alter the value of sloth, but it permits you to have ps point to another location. In short, finger and *ps are both const, and *finger and ps are not const![](E:\icodeworld.github.io\os_lab\c++ Primer Plus(sixth)\assets\XHV@G5ID]02AFTPB`5]8Z58.png)

##### Two-Dimensional Arrays

```
int sum(int (*ar2)[4], int size);
// or int sum(int ar2[][4], int size);
```

```c++
int sum(int ar2[][4], int size)
{
    int total = 0;
    for (int r = 0; r < size; r++)
    	for (int c = 0; c < 4; c++)
    		total +=ar2[r][c];
    return 0;
}

// or ar2[r][c] = *(*(ar2 + r) + c)	// same thing
ar2              // pointer to first row of an array of 4 int
ar2 + r          // pointer to row r (an array of 4 int)
*(ar2 + r)       // row r (an array of 4 int, hence the name of an array,
                 // thus a pointer to the first int in the row, i.e., ar2[r]

*(ar2 +r) + c    // pointer int number c in row r, i.e., ar2[r] + c
*(*(ar2 + r) + c) // value of int number c in row r, i.e. ar2[r][c]
```

##### String

```c++
The function itself demonstrates a standard way to process the characters in a string:
while (*str)
{
    statements
    str++;
}
```

```c++
#include <iostream>
const int Max = 5;
int fill_array(double ar[], int limit);
void show_array(const double ar[], int n);	// don't change data
void revalue(double r, double ar[], int n);

int main()
{
	using namespace std;
	double properties[Max];
	
	cin.get();
	cout << "a ";
	cin.get();
	int size = fill_array(properties, Max);
	show_array(properties, size);
	if (size > 0)
	{
		cout << "Enter revaluation factor: ";
		double factor;
		while (!(cin >> factor))	// bad input 
		{
			cin.clear();
			while (cin.get() != '\n')
				continue;
			cout << "Bad input; Please enter a number: ";
		}
		revalue(factor, properties, size);
		show_array(properties, size);
	}
	cout << "Done.\n";
	cin.get();
	cin.get();
	return 0;
}

int fill_array(double ar[], int limit)
{
	using namespace std;
	double temp;
	int i;
	for (i = 0; i < limit; i++)
	{
		cout << "Enter value #" << (i + 1) << ": ";
		cin >> temp;
		if (!cin)	// bad input
		{
			cin.clear();
			while (cin.get() != '\n')
				continue;
			cout << "Bad input; input process terminated.\n";
			break;
		}
		else if (temp < 0)	// signal to terminate
			break;
		ar[i] = temp;
	}
	return i;
}

void show_array(const double ar[], int n)
{
	using namespace std;
	for (int i = 0; i < n; i++)
	{
		cout << "Property #" << (i + 1) << ": $";
		cout << ar[i] << endl;
	}
}

void revalue(double r, double ar[], int n)
{
	for (int i = 0; i < n; i++)
		ar[i] *= r;
}
```

• When calling the function, pass it the address of the structure (&pplace) rather than the structure itself (pplace).
• Declare the formal parameter to be a pointer-to-polar—that is, type polar *. Because the function shouldn’t modify the structure, use the const modifier.
• Because the formal parameter is a pointer instead of a structure, use the indirect membership operator (->) rather than the membership operator (dot).

##### Recursion

![1541747357751](E:\icodeworld.github.io\os_lab\c++ Primer Plus(sixth)\assets\1541747357751.png)

##### Function pointer

Obtaining the address of a function is simple: You just use the function name without trailing parentheses. That is, if think() is a function, then think is the address of the function. To pass a function as an argument, you pass the function name. Be sure you distinguish between passing the address of a function and passing the return value of a function:

```c++
process(think);    // passes address of think() to process()
thought(think());  // passes return value of think() to thought()
```

In general, to declare a pointer to a particular kind of function, you can first write a prototype for a regular function of the desired kind and then replace the function name with an expression in the form (*pf). In this case, pf is a pointer to a function of that type.

```C++
double pam(int);  // prototype

Here’s what a declaration of an appropriate pointer type looks like:
double (*pf)(int);   // pf points to a function that takes
                     // one int argument and that
                     // returns type double
```

```C++
double pam(int);
double (*pf)(int);
pf = pam;            // pf now points to the pam() function
double x = pam(4);   // call pam() using the function name
double y = (*pf)(5); // call pam() using the pointer pf

Actually, C++ also allows you to use pf as if it were a function name:
double y = pf(5);    // also call pam() using the pointer pf

Using the first form is uglier, but it provides a strong visual reminder that the code is using a function pointer.
```



![1541748724977](E:\icodeworld.github.io\os_lab\c++ Primer Plus(sixth)\assets\1541748724977.png)

```c++
const double * f1(const double ar[], int n);
const double * f2(const double [], int);
const double * f3(const double *, int);
```

![1541749476268](E:\icodeworld.github.io\os_lab\c++ Primer Plus(sixth)\assets\1541749476268.png)

![1541749594499](E:\icodeworld.github.io\os_lab\c++ Primer Plus(sixth)\assets\1541749594499.png)

![1541749663545](E:\icodeworld.github.io\os_lab\c++ Primer Plus(sixth)\assets\1541749663545.png)

## Chapter Review

1. What are the three steps in using a function?
2. Construct function prototypes that match the following descriptions:
  a. `igor()` takes no arguments and has no return value.
  b. tofu() takes an int argument and returns a float.
  c. mpg() takes two type double arguments and returns a double.
  d. summation() takes the name of a long array and an array size as values and returns a long value.
  e. doctor() takes a string argument (the string is not to be modified) and returns a double value.
  f. `ofcourse()` takes a boss structure as an argument and returns nothing.
  g. plot() takes a pointer to a map structure as an argument and returns a string.

3. Write a function that takes three arguments: the name of an int array, the array size, and an int value. Have the function set each element of the array to the int value.

4. Write a function that takes three arguments: a pointer to the first element of a range in an array, a pointer to the element following the end of a range in an array, and an int value. Have the function set each element of the array to the int value.

5. Write a function that takes a double array name and an array size as arguments and returns the largest value in that array. Note that this function shouldn’t alter the contents of the array.

6. Why don’t you use the const qualifier for function arguments that are one of the fundamental types?

7. What are the three forms a C-style string can take in a C++ program?

8. Write a function that has this prototype:
  int replace(char * str, char c1, char c2);

  Have the function replace every occurrence of c1 in the string str with c2,and have the function return the number of replacements it makes.

9. What does the expression *"pizza" mean? What about "taco"[2]?

10. C++ enables you to pass a structure by value, and it lets you pass the address of a structure. If glitz is a structure variable, how would you pass it by value? How would you pass its address? What are the trade-offs of the two approaches?

11. The function judge() has a type int return value. As an argument, it takes the address of a function. The function whose address is passed, in turn, takes a pointer to a const char as an argument and returns an int. Write the function prototype.

12. Suppose we have the following structure declaration:

    ```
    struct applicant {
    char name[30];
    int credit_ratings[3];
    };
    ```

    a. Write a function that takes an applicant structure as an argument and displays its contents.
    b. Write a function that takes the address of an applicant structure as an argument and displays the contents of the pointed-to structure.

13. Suppose the functions f1() and f2() have the following prototypes:
    void f1(applicant * a);
    const char * f2(const applicant * a1, const applicant * a2);

    Declare p1 as a pointer that points to f1 and p2 as a pointer to f2. Declare `ap` as an array of five pointers of the same type as p1, and declare pa as a pointer to an array of ten pointers of the same type as p2. Use `typedef` as an aid.

## Answer

1. To use a function, you need to provide a definition and a prototype, and you have to use a function call. The function definition is the code that implements what the function does. The function prototype describes the function interface: how many and what kinds of values to pass to the function and what sort of return type, if any, to get from it.

2. .

   ```c++
   void igor(void);
   
   float tofu(int n);
   
   double map(double x1, double x2);
   
   long summation(long x[], int n);
   
   double doctor(const char * str);
   
   void ofcourse(boss);
   
   char * plot(map * pt);
   ```

3. .

   ```c++
   void set(int ar[], int size, int value)
   {
       for (int i = 0; i < size; i++)
       	ar[i] = value;
   }
   ```

4. .

   ```c++
   void set(int * begin, int * end, int value)
   {
        for (int * pt = begin; pt != end; pt++)
       	*pt = value;
   }
   ```






