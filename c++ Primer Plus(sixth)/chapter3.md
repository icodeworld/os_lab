[TOC]

## Unfamiliar points of knowledge

##### Data property

To store an item of information in a computer,the program must keep track of three fundamental properties:

1. Where the information is stored 
2. What value is kept there
3. What kind of information is stored

##### Names for variables

Names beginning with two underscore characters or with an underscore character followed by an uppercase letter are reserved for use by the implementation—that is, the compiler and the resources it uses. Names beginning with a single underscore character are reserved for use as global identifiers by the implementation.

##### Integer Literals

C++ uses the first digit or two to identify the base of a number constant. If the first digit is in the range 1–9, the number is base 10 (decimal); thus 93 is base 10. If the first digit is 0 and the second digit is in the range 1–7, the number is base 8 (octal); thus 042 is octal and equal to 34 decimal. If the first two characters are 0x or 0X, the number is base 16 (hexadecimal); thus 0x42 is hex and equal to 66 decimal. For hexadecimal values, the characters a–f and A–F represent the hexadecimal digits corresponding to the values 10–15.

##### Type Conversions

To help deal with this potential mishmash, C++ makes many type conversions automatically:

1. C++ converts values when you assign a value of one arithmetic type to a variable of another arithmetic type.
2. C++ converts values when you combine mixed types in expressions.
3. C++ converts values when you pass arguments to functions.

##### Type Casts

`cout << int('Q');  // displays the integer code for 'Q'`

More generally, you can do the following:
(typeName) value   // converts value to typeName type
`typeName (value)   // converts value to typeName type`

The first form is straight C. The second form is pure C++. The idea behind the new form is to make a type cast look like a function call. This makes type casts for the built-in types look like the type conversions you can design for user-defined classes.

More generally, you can do the following:
`static_cast<typeName> (value)   // converts value to typeName type`

The static_cast<> operator is more restrictive than the traditional type cast.

## Chapter Review

> 1. Why does C++ have more than one integer type?
>
> 2. Declare variables matching the following descriptions:
>   a. A short integer with the value 80
>   b. An unsigned int integer with the value 42,110
>   c. An integer with the value 3,000,000,000
>
> 3. What safeguards does C++ provide to keep you from exceeding the limits of an integer type?
>
> 4. What is the distinction between 33L and 33?
>
> 5. What is the distinction between 33L and 33?
>
> 6. Consider the two C++ statements that follow:
>   char grade = 65;
>   char grade = 'A';
>
>   Are they equivalent?
>
> 7. How could you use C++ to find out which character the code 88 represents? Come up with at least two ways.
> 8. Assigning a long value to a float can result in a rounding error. What about assigning long to double? long long to double?
> 9. Evaluate the following expressions as C++ would:
>   a. 8 * 9 + 2
>   b. 6 * 3 / 4
>   c. 3 / 4 * 6
>   d. 6.0 * 3 / 4
>   e. 15 % 4
> 10. Suppose x1 and x2 are two type double variables that you want to add as integers and assign to an integer variable. Construct a C++ statement for doing so. What if you want to add them as type double and then convert to int?
> 11. What is the variable type for each of the following declarations?
>     a. auto cars = 15;
>     b. auto iou = 150.37f;
>     c. auto level = 'B';
>     d. auto crat = U'/U00002155';
>     e. auto fract = 8.25f/2.5;

### Answer

1. Having more than one integer type lets you choose the type that is best suited to a particular need. For example, you could use short to conserve space or long to guarantee storage capacity or to find that a particular type speeds up a particular calculation.

2. ```c++
   short rbis = {80};          // = is optional
   unsigned int q {42110};     // could use = {42110}
   long long ants {3000000000};
   
   3. C++ provides no automatic safeguards to keep you from
   ```

3. C++ provides no automatic safeguards to keep you from exceeding integer limits; you can use the climits header file to determine what the limits are.

4. The constant 33L is type `long`, whereas the constant 33 is type int.

5. They are equivalent.`int 65` is converted to char 'A'.

6. The following:

   ```c++
   char letter = 88;
   cout << letter\n;		// char type prints as character
   
   cout.put(char(88));		// put() prints char as character
   
   cout << char(88) << endl;	// new-style type cast value to char
   
   cout << (char)88 << endl;	// old-style type cast value to char
   ```

7. The answer depends on how large the two types are.

8. 74   ,     4 ,       0 ,         4.5 ,           3

9. The following:

   `int(x3) = int(x1) + int(x2);	// add as integers and assign to an integer variable`

   `int(x3) = x1 + x2; // dd them as type double and then convert to int `

10. The following:

    ```c++
     auto cars = 15;			// int
     auto iou = 150.37f;		// float
     auto level = 'B';			// char
     auto crat = U'/U00002155';	// char32_t
     auto fract = 8.25f/2.5;	// double
    ```

## Programming Exercises

> 1. Write a short program that asks for your height in integer inches and then converts your height to feet and inches. Have the program use the underscore character to indicate where to type the response. Also use a const symbolic constant to represent the conversion factor.
>
>    ```c++
>    
>    ```
>
> 2. Write a short program that asks for your height in feet and inches and your weight in pounds. (Use three variables to store the information.) Have the program report your body mass index (BMI). To calculate the BMI, first convert your height in feet and inches to your height in inches (1 foot = 12 inches). Then convert your height in inches to your height in meters by multiplying by 0.0254. Then convert your weight in pounds into your mass in kilograms by dividing by 2.2. Finally, compute your BMI by dividing your mass in kilograms by the square of your height in meters. Use symbolic constants to represent the various conversion factors.
>
>    ```c++
>    // convert.cpp
>    #include <iostream>
>    using namespace std;
>    double convert(double std);
>    int main() {
>    	double inch, feet, pound;
>    	cin >> feet;
>    	cin >> pound;
>    	cout << feet << endl;
>    	cout << convert(feet) << endl;
>    	cout << pound << endl;
>    }
>    
>    double convert(double std)
>    {
>    	return 12 * std;
>    }
>    ```
>
> 3. Write a program that asks the user to enter a latitude in degrees, minutes, and seconds and that then displays the latitude in decimal format. There are 60 seconds of arc to a minute and 60 minutes of arc to a degree; represent these values with symbolic constants. You should use a separate variable for each input value. A sample run should look like this:
>
>    ```c++
>    Enter a latitude in degrees, minutes, and seconds:
>    First, enter the degrees: 37
>    Next, enter the minutes of arc: 51
>    Finally, enter the seconds of arc: 19
>    37 degrees, 51 minutes, 19 seconds = 37.8553 degrees
>    ```
>
>    ```c++
>    // convert.cpp
>    #include <iostream>
>    const int Con = 60;
>    using namespace std;
>    int main() {
>    	float degree, munite, second;
>    	cout << "Enter a latitude in degrees, minutes, and seconds:\nFirst, enter the degrees: ";
>    	cin >> degree;
>    	cout << "First, enter the degrees: ";
>    	cin >> munite;
>    	cout << "Finally, enter the seconds of arc: ";
>    	cin >> second;
>    	float latitude = degree + munite / Con + second / Con / Con;
>    	cout << degree << " degrees, " << munite << " minutes, " << second << " seconds = " << latitude << " degrees";
>    }
>    ```
>
> 4. Write a program that asks the user to enter the number of seconds as an integer value (use type `long`, or, if available, `long` `long`) and that then displays the equivalent time in days, hours, minutes, and seconds. Use symbolic constants to represent the number of hours in the day, the number of minutes in an hour, and the number of seconds in a minute. The output should look like this:
>
>    ```c++
>    Enter the number of seconds: 31600000
>    31600000 seconds = 365 days, 17 hours, 46 minutes, 40 seconds
>    ```
>
>    ```c++
>    // convert.cpp
>    
>    #include <iostream>
>    using namespace std;
>    int main() {
>    	const int hours = 24;
>    	const int minutes = 60;
>    	const int seconds = 60;
>    	long long total;
>    	cout << "Enter the number of seconds: ";
>    	cin >> total;
>    	cout << total << " seconds = "
>    	<< total / (hours * minutes * seconds)
>    	<< " days, "
>    	<< total % (hours * minutes * seconds) / (minutes * seconds)
>    	<< " hours, "
>    	<< total  % (minutes * seconds) / seconds
>    	<< " minutes, "
>    	<< total % seconds
>    	<< " seconds";
>    }
>    ```
>
> 5. Write a program that requests the user to enter the current world population and the current population of the U.S. (or of some other nation of your choice). Store the information in variables of type long long. Have the program display the percent that the U.S. (or other nation’s) population is of the world’s population. The output should look something like this:
>
>    ```c++
>    Enter the world's population: 6898758899
>    Enter the population of the US: 310783781
>    The population of the US is 4.50492% of the world population.
>    ```
>
>    ```c++
>    // convert.cpp
>    
>    #include <iostream>
>    using namespace std;
>    int main() {
>    	long long tpopulation;
>    	long long population;
>    	cout << "Enter the world's population: ";
>    	cin >> tpopulation;
>    	cout << "Enter the population of the US: ";
>    	cin >> population;
>    	cout << "The population of the US is "
>    		 << double(population) / double(tpopulation) * 100
>    		 << "% of the world population.";
>    }
>    ```
>
>    I have a problem,and I use '%' this character,due to %  escape character.
>
> 6. Write a program that asks how many miles you have driven and how many gallons of gasoline you have used and then reports the miles per gallon your car has gotten. Or, if you prefer, the program can request distance in kilometers and petrol in liters and then report the result European style, in liters per 100 kilometers.
>
>    ```c++
>    // convert.cpp
>    
>    #include <iostream>
>    using namespace std;
>    int main() {
>    	float distance;
>    	float gasoline;
>    	cout << "Enter the distance: ";
>    	cin >> distance;
>    	cout << "Enter the petrol: ";
>    	cin >> gasoline;
>    	cout << gasoline / distance * 100 << " liters per 100 kilometers.";
>    }
>    ```
>
> 7. Write a program that asks you to enter an automobile gasoline consumption figure in the European style (liters per 100 kilometers) and converts to the U.S. style of miles per gallon. Note that in addition to using different units of measurement, the U.S. approach (distance / fuel) is the inverse of the European approach (fuel / distance). Note that 100 kilometers is 62.14 miles, and 1 gallon is 3.875 liters. Thus, 19 mpg is about 12.4 l/100 km, and 27 mpg is about 8.7 l/100 km.
>
>    ```c++
>    // convert.cpp
>    
>    #include <iostream>
>    using namespace std;
>    float convert1(float distance);
>    float convert2(float g);
>    int main() {
>    	float distance;
>    	float gasoline;
>    	cout << "Enter the distance: ";
>    	cin >> distance;
>    	cout << "Enter the petrol: ";
>    	cin >> gasoline;
>    	cout << gasoline / distance * 100 << " liters per 100 kilometers.\n";
>    	distance = convert1(distance);
>    	gasoline = convert2(gasoline);
>    	cout << distance / gasoline << " mpg.";
>    }
>    
>    float convert1(float distance)
>    {
>    	return distance * 0.6214;
>    }
>    
>    float convert2(float g)
>    {
>    	return g / 3.875;
>    }
>    ```

1. Having more than one integer type lets you choose the type that is best suited to a particular need. For example, you could use short to conserve space or long to guarantee storage capacity or to find that a particular type speeds up a particular calculation.

2. ```c++
   short si = {80};
   unsigned int mi = {42110};
   long long hi = {3,000,000,000};
   ```

3. C++ provides no automatic safeguards to keep you from exceeding integer limits; you can use the climits header file to determine what the limits are.

4. The constant 33L is type long, wher