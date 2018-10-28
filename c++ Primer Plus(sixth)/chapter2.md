[TOC]

## Chapter Review

> 1. What are the modules of C++ programs called?
> 2. What does the following preprocessor directive do?
>     #include <iostream>
>
> 3. What does the following statement do?
>     using namespace std;
>
> 4. What statement would you use to print the phrase “Hello, world” and then start a new line?
> 5. What statement would you use to create an integer variable with the name cheeses?
> 6. What statement would you use to assign the value 32 to the variable cheeses?
> 7. What statement would you use to read a value from keyboard input into the variable cheeses?
> 8. What statement would you use to print “We have X varieties of cheese,” where the current value of the cheeses variable replaces X?
> 9. What do the following function prototypes tell you about the functions?
>     int froop(double t);
>     void rattle(int n);
>     int prune(void);
>
> 10. When do you not have to use the keyword return when you define a function?
> 11. Suppose your main() function has the following line:
>     cout << "Please enter your PIN: ";
>
> And suppose the compiler complains that cout is an unknown identifier. What is the likely cause of this complaint, and what are three ways to fix the problem?

### Answers

> 1. They are called functions.
>
> 2. This directive causes the preprocessor to add the contents of  the iostream file to your program.This is a typical preprocessor action:adding or replacing text in the source code before it's compiled.
>
> 3. The namespace facility lets a vendor
>    package its wares in a unit called a namespace so that you can use the name of a namespace
>    to indicate which vendor’s product you want. 
>
> 4. `cout <<  "Hello, world" << endl;`
>
> 5. `int cheeses;`
>
> 6. `cheeses = 32;`
>
> 7. `cin >> cheeses;`
>
> 8. `cout << "We have " << cheeses << " varieties of cheese\n";`
>
> 9. ```c++
>    int froop(double t);	//the type of argument is double,the type of return is int 
>    void rattle(int n);		//the type of argument is int,the type of return is void 
>    int pune(void);			//the type of argument is void,the type of return is int
>    ```
>
> 10. You don't have to use `return` in a function when the function has the return type `void`.However,you can use it if you don't give a return value: `return;` 
>
> 11. namespace
>
>     1.Replacing with the statement `std::cout << "Please enter your PIN: ";`
>
>     2.Adding the statement `using namespace std;`within the function 
>
>     3.Adding the statement `using namespace std;`in head file

## Programming Exercises

> 1. Write a C++ program that displays your name and address (or if you value your privacy, a fictitious name and address).
>
> 2. Write a C++ program that asks for a distance in furlongs and converts it to yards. (One furlong is 220 yards.)
>
> 3. Write a C++ program that uses three user-defined functions (counting main() as one) and produces the following output:
>     Three blind mice
>     Three blind mice
>     See how they run
>     See how they run
>
>   One function, called two times, should produce the first two lines, and the remaining function, also called twice, should produce the remaining output.
>
> 4. Write a program that asks the user to enter his or her age. The program then should display the age in months:
>     Enter your age: 29
>
>   Your age in months is 384.
>
> 5. Write a program that has main() call a user-defined function that takes a Celsius temperature value as an argument and then returns the equivalent Fahrenheit value. The program should request the Celsius value as input from the user and display the result, as shown in the following code:
>     Please enter a Celsius value: 20
>     20 degrees Celsius is 68 degrees Fahrenheit.
>
>   For reference, here is the formula for making the conversion:
>   Fahrenheit = 1.8 × degrees Celsius + 32.0
>
> 6. Write a program that has main() call a user-defined function that takes a distance in light years as an argument and then returns the distance in astronomical units. The program should request the light year value as input from the user and display the result, as shown in the following code:
>     Enter the number of light years: 4.2
>     4.2 light years = 265608 astronomical units.
>
>   An astronomical unit is the average distance from the earth to the sun (about 150,000,000 km or 93,000,000 miles), and a light year is the distance light travels in a year (about 10 trillion kilometers or 6 trillion miles). (The nearest star after the sun is about 4.2 light years away.) Use type double (as in Listing 2.4) and this conversion factor:
>   1 light year = 63,240 astronomical units
>
> 7. Write a program that asks the user to enter an hour value and a minute value. The main() function should then pass these two values to a type void function that displays the two values in the format shown in the following sample run:
>     Enter the number of hours: 9
>     Enter the number of minutes: 28
>     Time: 9:28

### Answer

1. name and address

   ```c++
   // myinformation.cpp -- name and address
   
   #include <iostream>
   
   int main()
   {
   	using namespace std;
   	
   	cout << "my name is Hujie."
   		 << endl
   		 << "my address is China.";
   	return 0;
   }
   ```

   ![1540625175988](E:\icodeworld.github.io\os_lab\c++ Primer Plus(sixth)\assets\1540625175988.png)

2. convert

   ```c++
   // convert.cpp
   
   #include <iostream>
   using namespace std;
   int convert(int);       // function prototype
   
   int main()
   {
   	int distance;
   	cin >> distance;
   	cout << "distance is "
   		 << distance
   		 << " furlongs"
   		 << endl;
   	distance = convert(distance);
   	cout << "equal to "
   		 << distance
   		 << " yards";
   	return 0;
   }
   
   int convert(int temp)
   {
   	return 220 * temp;
   }
   ```

   ![1540625929200](E:\icodeworld.github.io\os_lab\c++ Primer Plus(sixth)\assets\1540625929200.png)

3. user-defined functions

   ```c++
   // user-defined functions
   
   #include <iostream>
   using namespace std;
   void object(void);
   void process(void);// function prototype
   int main()
   {
   	object();
   	object();
   	process();
   	process();
   	return 0;
   }
   
   void object()
   {
   	cout << "Three blind mice" << endl;
   }
   
   void process()
   {
   	cout << "See how they run" << endl;
   }
   ```

   ![1540626625723](E:\icodeworld.github.io\os_lab\c++ Primer Plus(sixth)\assets\1540626625723.png)

4. convert_int

   ```c++
   // convert.cpp -- converts stone to pounds
   #include <iostream>
   using namespace std;       // affects all function definitions
   int convert(int);        // function prototype
   int main()
   {
   	int age;
   	cout << "Enter your age: ";
   	cin >> age;
   	age = convert(age);
   	cout << age;
   }
   
   int convert(int sts)
   {
   	return 12 * sts;
   }
   ```

   ![1540626896185](E:\icodeworld.github.io\os_lab\c++ Primer Plus(sixth)\assets\1540626896185.png)

5. convert_float

   ```c++
   // convert.cpp -- converts stone to pounds
   #include <iostream>
   using namespace std;       // affects all function definitions
   float convert(float);        // function prototype
   int main()
   {
       float celsius;
   	cout << "Please enter a Celsius value: ";
   	cin >> celsius;
   	float Fahrenheit = convert(celsius);
   	cout
   		 << celsius
   		 << " degrees Celsius is "
   		 << Fahrenheit
   		 << " degrees Fahrenheit." ;
   }
   
   float convert(float sts)
   {
   	return 1.8 * sts + 32.0;
   }
   ```

   ![1540627491721](E:\icodeworld.github.io\os_lab\c++ Primer Plus(sixth)\assets\1540627491721.png)

6. convert_double

   ```c++
   // convert_double
   #include <iostream>
   using namespace std;       // affects all function definitions
   double convert(double);        // function prototype
   int main()
   {
       double lightyear;
   	cout << "Enter the number of light years: ";
   	cin >> lightyear;
   	double distance = convert(lightyear);
   	cout
   		 << lightyear
   		 << " light years = "
   		 << distance
   		 << " astronomical units." ;
   }
   
   double convert(double sts)
   {
   	return 63240 * sts;
   }
   ```

   ![1540628017764](E:\icodeworld.github.io\os_lab\c++ Primer Plus(sixth)\assets\1540628017764.png)

7. more arguments

   ```c++
   // convert_double
   #include <iostream>
   using namespace std;       // affects all function definitions
   void link(int,int);        // function prototype
   int main()
   {
   	int hours;
   	int minutes;
   	cout << "Enter the number of hours: ";
   	cin >> hours;
   	cout << "Enter the number of minutes: ";
   	cin >> minutes;
   	link(hours,minutes);
   	return 0;
   }
   
   void link(int hour,int minute)
   {
   	cout << "Time: "
   		 << hour
   		 << ":"
   		 << minute;
   }
   ```

   ![1540628513427](E:\icodeworld.github.io\os_lab\c++ Primer Plus(sixth)\assets\1540628513427.png)

