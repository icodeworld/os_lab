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

5. .

   ```c++
   double max(const double ar[], int size)
   {
       double max;
       if (size < 1)
       {
           cout << "Invalid array size of " << size << endl;
           cout << "Returning a value of 0\n";
           return 0;
       }
       else
       {
           max = ar[0];
           for (int i = 0; i < size; i++)
           	if (max < ar[i])
               	max = ar[i];
           return max;
       }
   }
   ```

6. You use the const qualifier with pointers to protect the original pointed-to data from being altered. When a program passes a fundamental type such as an int or a double, it passes it by value so that the function works with a copy. Thus, the original data is already protected.

7. A string can be stored in a char array, it can be represented by a string constant in double quotation marks, and it can be represented by a pointer pointing to the first character of a string.

8. .

   ```c++
   int replace(char * str, char c1, char c2)
   {
   	int count = 0;
       while (*str != '\0')
       {
           if (c1 == * str)
           {
               *str = c2;
           	count++; 
           }
   		str++;		// advance to next character
       }	
       return count;
   }
   ```

9. Because C++ interprets "pizza" as the address of its first element, applying the * operator yields the value of that first element, which is the character p. Because C++ interprets "taco" as the address of its first element, it interprets "taco"[2] as the value of the element two positions down the line—that is, as the character c. In other words, the string constant acts the same as an array name.

10. To pass it by value, you just pass the structure name glitz. To pass its address, you use the address operator &glitz. Passing by the value automatically protects the original data, but it takes time and memory. Passing by address saves time and memory but doesn’t protect the original data unless you use the const modifier for the function parameter. Also passing by value means you can use ordinary structure member notation, but passing a pointer means you have to remember to use the indirect membership operator.

11. `int judge(int (*pf)(const char *));`

12. a

    ```c++
    void display(applicant ap)
    {
        cout << ap.name << endl;
        for (int i = 0; i < 3; i++)
            cout << ap.credit_ratings[i] << endl;
    }
    ```

    b

    ```c++
    void show(const applicant * pt)
    {
        cout << pt->name << endl;
        for (int i = 0; i < 3; i++)
        	cout << pt->credit_ratings[i] << endl;
    }
    ```

13. .

    ```c++
    typedef void (*p_f1)(applicant *);
    p_f1 p1 = f1;
    
    typedef const char * (*P_f2)(const applicant *, const applicant *);
    p_f2 p2 = f2;
    
    p_f1 ap[5];
    
    p_f2 ap2[10];
    p_f2 (*pa)[10] = &ap2;		// pa points to an array of 3 function pointers
    ```

## Programming Exercises

1. Write a program that repeatedly asks the user to enter pairs of numbers until at least one of the pair is 0. For each pair, the program should use a function to calculate the harmonic mean of the numbers. The function should return the answer to main(), which should report the result. The harmonic mean of the numbers is the inverse of the average of the inverses and can be calculated as follows:
  harmonic mean = 2.0 × x × y / (x + y)

  ```c++
  #include <iostream>
  double ave(double x, double y);
  int main()
  {
  	using namespace std;
  	double x;
  	double y;
  	
  	cout << "Enter the x and y values: ";
  	while (!(cin >> x >> y)) // bad input
  	{
  		cin.clear();
  		while (cin.get() != '\n')
  			  continue;
  		cout << "Bad input; Please enter two numbers: ";
  	}
  	
  	while (x && y)
  	{
  	    cout << "harmonic mean of " << x << ", " << y << " = " << ave(x,y) << endl;
  		cout << "Enter again(0 to quit): ";
  		cin >> x >> y;
  	}
  
  	return 0;
  }
  
  double ave(double x, double y)
  {
  	return 2.0 * x * y / (x + y);
  }
  ```

2. Write a program that asks the user to enter up to 10 golf scores, which are to be stored in an array. You should provide a means for the user to terminate input prior to entering 10 scores. The program should display all the scores on one line and report the average score. Handle input, display, and the average calculation with three separate array-processing functions.

   ```c++
   #include <iostream>
   using namespace std;
   const int Max = 10;
   
   int fill(double grade[], int Max);
   void show(double const grade[], int i);
   double ave(double const grade[], int i);
   
   int main()
   {
   	double grade[Max];
   	int size = fill(grade, Max);
   	show(grade, size);
   	cout << "\nAverage is: " << ave(grade, size) << endl;
   	cout << "Done.\n";
   	cin.get();
   	cin.get();
   	return 0;
   }
   
   int fill(double grade[], int Max)
   {
   	double temp;
   	int i;
   	for (i = 0; i < Max; i++)
   	{
   		cout << "Enter value #" << (i + 1) << ": ";
   		cin >> temp;
   		if (!cin)   // bad input
   		{
   			cin.clear();
   			while (cin.get() != '\n')
   				continue;
   			cout << "Bad input; Please enter two numbers: ";
   			break;
   		}
   		else if (temp < 0)
   			break;
   		grade[i] = temp;
   	}
   	return i;
   }
   void show(double const grade[], int i)
   {
   	cout << "\nGrade are: ";
   	for (int j = 0; j < i; j++)
   		cout << grade[j] << "  ";
   }
   
   double ave(double const grade[], int i)
   {
   	double average = 0;
   	for (int j = 0; j < i; j++)
   		average += grade[j];
   	average = average / i;
   	return average;
   }
   ```

3. Here is a structure declaration:

   ```c++
   struct box
   {
         char maker[40];
         float height;
         float width;
         float length;
         float volume;
   };
   ```

   a. Write a function that passes a box structure by value and that displays the value of each member.

   ```c++
   box show(box mm)
   {
   	cout << mm.maker << endl;
   	cout << mm.height << endl;
   	cout << mm.width << endl;
   	cout << mm.length << endl;
   	cout << mm.volume << endl;
   }
   ```

   b. Write a function that passes the address of a box structure and that sets the volume member to the product of the other three dimensions.

   ```c++
   box set(box * pa)
   {
   	pa->volume = pa->height * pa->width * pa->length;
   }
   ```

   c. Write a simple program that uses these two functions.

   ```c++
   #include <iostream>
   using namespace std;
   struct box
   {
   	char maker[40];
   	float height;
   	float width;
   	float length;
   	float volume;
   };
   
   box set(box *);
   box show(box mm);
   
   
   int main()
   {
   	box mm = {"Hj", 20, 40, 50.0, 1000};
   	set(&mm);
   	show(mm);
   	cout << "Done.\n";
   	return 0;
   }
   
   box set(box * pa)
   {
   	pa->volume = pa->height * pa->width * pa->length;
   }
   
   box show(box mm)
   {
   	cout << mm.maker << endl;
   	cout << mm.height << endl;
   	cout << mm.width << endl;
   	cout << mm.length << endl;
   	cout << mm.volume << endl;
   }
   ```


4. Many state lotteries use a variation of the simple lottery portrayed by Listing 7.4. In these variations you choose several numbers from one set and call them the field numbers. For example, you might select five numbers from the field of 1–47). You also pick a single number (called a mega number or a power ball, etc.) from a second range, such as 1–27. To win the grand prize, you have to guess all the picks correctly. The chance of winning is the product of the probability of picking all the field numbers times the probability of picking the mega number. For instance, the probability of winning the example described here is the product of the probability of picking 5 out of 47 correctly times the probability of picking 1 out of 27 correctly. Modify Listing 7.4 to calculate the probability of winning this kind of lottery.

   ```c+
   // lotto.cpp -- probability of winning
   #include <iostream>
   // Note: some implementations require double instead of long double
   long double probability(unsigned numbers, unsigned picks);
   long double count(unsigned number1, unsigned pick1, unsigned number2, unsigned pick2);
   int main()
   {
   	using namespace std;
   	double total1, choice1;
   	double total2, choice2;
   	cout << "Enter the total number of choices on the game card and\n"
   			"the number of picks allowed:\n";
   	while ((cin >> total1 >> choice1 >> total2 >> choice2) && (choice1 <= total1) && (choice2 <= total2))
   	{
   		cout << "You have one chance in ";
   		cout << count(total1, choice1, total2, choice2);
   		cout << " of winning.\n";
   		cout << "Next four numbers (q to quit): ";
   	}
   	cout << "bye\n";
   	return 0;
   }
   
   // the following function calculates the probability of picking picks
   // numbers correctly from numbers choices
   long double probability(unsigned numbers, unsigned picks)
   {
   	long double result = 1.0;	// here come some local variables
   	long double n;
   	unsigned p;
   
   	for (n = numbers, p = picks; p > 0; n--, p--)
   		result = result * n / p ;
   	return result;
   }
   
   long double count(unsigned number1, unsigned pick1, unsigned number2, unsigned pick2)
   {
   	return probability(number1,pick1) * probability(number2,pick2);
   }
   ```

5. Define a recursive function that takes an integer argument and returns the factorial of that argument. Recall that 3 factorial, written 3!, equals 3 × 2!, and so on, with 0! defined as 1. In general, if n is greater than zero, n! = n * (n - 1)!. Test your function in a program that uses a loop to allow the user to enter various values for which the program reports the factorial.

   ```c++
   #include <iostream>
   const int Max = 20;
   long double count(int n);
   int main()
   {
   	using namespace std;
   	int temp;
   	int i;
   	for (i = 0; i < Max; i++)
   	{
   		cout << "Enter value #" << (i + 1) << ": ";
   		cin >> temp;
   		if (!cin)   // bad input
   		{
   			cin.clear();
   			while (cin.get() != '\n')
   				continue;
   			cout << "Bad input; Please enter two numbers: ";
   			break;
   		}
   		else if (temp < 0)
   			break;
   		cout << "The factorial of " << temp << " is " <<  count(temp) << endl;
   	}
   	return i;
   	cout << "Bye!\n";
   	return 0;
   }
   
   long double count(int n)
   {
   	using namespace std;
   	long double result;
   	if (0 < n)
   		result = n * count(n-1);
   	else result = 1;
   	return result;
   }
   ```

6. Write a program that uses the following functions:

   Fill_array() takes as arguments the name of an array of double values and an array size. It prompts the user to enter double values to be entered in the array. It ceases taking input when the array is full or when the user enters non-numeric input, and it returns the actual number of entries.
   Show_array() takes as arguments the name of an array of double values and an array size and displays the contents of the array.
   Reverse_array() takes as arguments the name of an array of double values and an array size and reverses the order of the values stored in the array.
   The program should use these functions to fill an array, show the array, reverse the array, show the array, reverse all but the first and last elements of the array, and then show the array.

   ```c++
    #include <iostream>
   const int Max = 10;
   int Fill_array(double ar[], int limit);
   void Show_array(const double ar[], int n);	// don't valueange data
   void Reverse_array(double ar[], int n);
   
   int main()
   {
   	using namespace std;
   	double properties[Max];
   	
   	int size = Fill_array(properties, Max);
   	Show_array(properties, size);
   	cout << endl;
   	
   	Reverse_array(properties, size);
   	Show_array(properties, size);
   	cout << endl;
   	
   	double temp;
   	temp = properties[size-1];
   	properties[size-1] = properties[0];
   	properties[0] = temp;
   	Show_array(properties, size);
   		
   	cout << "\nDone.\n";
   	cin.get();
   	cin.get();
   	return 0;
   }
   
   int Fill_array(double ar[], int limit)
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
   
   void Show_array(const double ar[], int n)
   {
   	using namespace std;
   	for (int i = 0; i < n; i++)
   		cout << ar[i] << " ";
   }
   
   void Reverse_array(double ar[], int n)
   {
   	double temp;
   	for (int i = n - 1; i >= (n-1)/2; i--)
   	{
   		temp = ar[i];
   		ar[i] = ar[n-1-i];
   		ar[n-1-i] = temp;
   	}
   }
   ```

7. Redo Listing 7.7, modifying the three array-handling functions to each use two pointer parameters to represent a range. The fill_array() function, instead of returning the actual number of items read, should return a pointer to the location after the last location filled; the other functions can use this pointer as the second argument to identify the end of the data.

   ```c++
    #include <iostream>
   const int Max = 10;
   double * fill_array(double * begin, int limit);
   void show_array(const double * begin, const double * end);	// don't valueange data
   void revalue(double r, double * begin, const double * end);
   
   int main()
   {
   	using namespace std;
   	double properties[Max];
   	double * end;
   	end = fill_array(properties, Max);
   	show_array(properties, end);
   	if (end != properties)
   	{
   		cout << "Enter revaluation factor: ";
   		double factor;
   		while (!(cin >> factor))	// bad input 
   		{
   			cin.clear();
   			while (cin.get() != '\n')
   			{
   				  continue;
   			}
   			cout << "Bad input; Please enter a number: ";
   		}
   		revalue(factor, properties, end);
   		show_array(properties, end);
   	}
   	cout << "Done.\n";
   	cin.get();
   	cin.get();
   	return 0;
   }
   
   double * fill_array(double * begin, int limit)
   {
   	using namespace std;
   	double temp;
   	double * pt;
   	int i;
   	for (i = 0, pt = begin; i < limit; i++, pt++)
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
   		begin[i] = temp;
   	}
   	return pt;
   }
   
   void show_array(const double * begin, const double * end)
   {
   	using namespace std;
   	const	double * pt;
   	int i = 0;
   	for (pt = begin; pt != end; i++, pt++)
   	{
   		cout << "Property #" << (i + 1) << ": $";
   		cout << *pt << endl;
   	}
   }
   
   void revalue(double r, double * begin, const double * end)
   {
   	double * pt;
   
   	for (pt = begin; pt != end;pt++)
   		* pt *= r;
   }
   ```

8. Redo Listing 7.15 without using the array class. Do two versions:
  a. Use an ordinary array of const char * for the strings representing the season names, and use an ordinary array of double for the expenses.

  ```c++
  #include <iostream>
  #include <string>
  using namespace std;
  const int Seasons = 4;
  const int Max = 20;
  char const * arr[Seasons] = {"Spring", "Summer", "Fall", "Winter"};
  
  void fill(char const * arr[Seasons], double expenses[Seasons]);
  void show(char const * arr[Seasons], double const expenses[Seasons]);
  
  int main()
  {
  	double expenses[Seasons];
  	fill(arr, expenses);
  	show(arr, expenses);
  	return 0;
  }
  
  void fill(char const * arr[Seasons], double expenses[Seasons])
  {
  	for (int i = 0; i < Seasons; i++)
  	{
  		cout << "Enter " << *(arr + i) << " expenses: ";
  		cin >> *(expenses + i);
  	}
  }
  
  void show(char const * arr[Seasons], double const expenses[Seasons])
  {
  	using namespace std;
  	double total = 0.0;
  	cout << "\nEXPENSES\n";
  	for (int i = 0; i < Seasons; i++)
  	{
  		cout << *(arr + i) << ": $" << *(expenses + i) << endl;
  		total += *(expenses + i);
  	}
  }
  ```

  b. Use an ordinary array of const char * for the strings representing the season names, and use a structure whose sole member is an ordinary array of double for the expenses. (This design is similar to the basic design of the array class.)

  ```c++
  #include <iostream>
  #include <string>
  using namespace std;
  const int Seasons = 4;
  const int Max = 20;
  const char * arr[Seasons] = {"Spring", "Summer", "Fall", "Winter"};
  
  struct box
  {
  	double expenses[Seasons];
  };
  
  box  fill(const char * arr[Seasons], box);
  void show(const char * arr[Seasons], const box *);
  
  int main()
  {
  	box * pt = new box;
  	*pt = fill(arr, *pt);
  	show(arr, pt);
  	
  	delete pt;
  	return 0;
  }
  
  box  fill(const char * arr[Seasons], box pp)
  {
  	for (int i = 0; i < Seasons; i++)
  	{
  		cout << "Enter " << *(arr + i) << " expenses: ";
  		cin >> (pp.expenses)[i];
  	}
  	return pp;
  }
  
  void show(const char * arr[Seasons], const box * pt)
  {
  	using namespace std;
  	double total = 0.0;
  	cout << "\nEXPENSES\n";
  	for (int i = 0; i < Seasons; i++)
  	{
  		cout << *(arr + i) << ": $" << (pt -> expenses)[i] << endl;
  		total += (pt -> expenses)[i];
  	}
  		cout << "Total Expenses: $" << total << endl;
  }
  ```

  #### Caution : It must return the structure or address after `fill()`,so the `fill()`can't be void type.If it is void, Then `show()`can't point to the structure having already filled.So program can't derive the right value.Because structure is passing by address.

9. This exercise provides practice in writing functions dealing with arrays and structures. The following is a program skeleton. Complete it by providing the described functions:

  ```c++
  #include <iostream>
  using namespace std;
  const int SLEN = 30;
  struct student {
      char fullname[SLEN];
      char hobby[SLEN];
      int ooplevel;
  };
  // getinfo() has two arguments: a pointer to the first element of
  // an array of student structures and an int representing the
  // number of elements of the array. The function solicits and
  // stores data about students. It terminates input upon filling
  // the array or upon encountering a blank line for the student
  // name. The function returns the actual number of array elements
  // filled.
  int getinfo(student pa[], int n);
  
  // display1() takes a student structure as an argument
  // and displays its contents
  void display1(student st);
  
  // display2() takes the address of student structure as an
  // argument and displays the structure's contents
  void display2(const student * ps);
  
  // display3() takes the address of the first element of an array
  // of student structures and the number of array elements as
  // arguments and displays the contents of the structures
  void display3(const student pa[], int n);
  
  int main()
  {
       cout << "Enter class size: ";
       int class_size;
       cin >> class_size;
       while (cin.get() != '\n')
           continue;
  
      student * ptr_stu = new student[class_size];
      int entered = getinfo(ptr_stu, class_size);
      for (int i = 0; i < entered; i++)
      {
          display1(ptr_stu[i]);
          display2(&ptr_stu[i]);
      }
      display3(ptr_stu, entered);
      delete [] ptr_stu;
      cout << "Done\n";
      return 0;
  }
  ```

10. Design a function calculate() that takes two type double values and a pointer to a function that takes two double arguments and returns a double. The calculate() function should also be type double, and it should return the value that the pointed-to function calculates, using the double arguments to calculate(). For example, suppose you have this definition for the add() function:

    ```
    double add(double x, double y)
    {
       return x + y;
    }
    ```

    Then, the function call in the following would cause calculate() to pass the values 2.5 and 10.4 to the add() function and then return the add() return value (12.9):
    `double q = calculate(2.5, 10.4, add);`

    Use these functions and at least one additional function in the add() mold in a program. The program should use a loop that allows the user to enter pairs of numbers. For each pair, use calculate() to invoke add() and at least one other function. If you are feeling adventurous, try creating an array of pointers to add()-style functions and use a loop to successively apply calculate() to a series of functions by using these pointers. Hint: Here’s how to declare such an array of three pointers:
    double (*pf[3])(double, double);

    You can initialize such an array by using the usual array initialization syntax and function names as addresses.