[TOC]

## Unfamiliar points of knowledge

#### Programming Tip

Common C++ style is to place a space between for and the following parenthesis and to omit space between a function name and the following parenthesis:

```c++
for (i = 6; i < 10; i++)
      smart_function(i);
```

Other control statements, such as if and while, are treated similarly to for. This serves to visually reinforce the distinction between a control statement and a function call. Also common practice is to indent the body of a for statement to make it stand out visually.

#### const

It’s usually a good idea to define a const value to represent the number of elements in an array. You can use the const value in the array declaration and in all other references to the array size, such as in a for loop.

#### n++ or ++n

However, although the choice between prefix and postfix forms has no effect on the program’s behavior, it is possible for the choice to have a small effect on execution speed. For built-in types and modern compilers, this seems to be a non issue. But C++ lets you define these operators for classes. In that case, the user defines a prefix function that works by incrementing a value and then returning it. But the postfix version works by first stashing a copy of the value, incrementing the value, and then returning the stashed copy. Thus, for classes, the prefix version is a bit more efficient than the postfix version.
In short, for built-in types, it most likely makes no difference which form you use. For user-defined types having user-defined increment and decrement operators, the prefix form is more efficient.

#### ++ and point

Incrementing and decrementing pointers follow pointer arithmetic rules. Thus, if pt points to the first member of an array, ++pt changes pt so that it points to the second member.

If you define a new variable inside a block, the variable persists only as long as the program is executing statements within the block. When execution leaves the block, the variable is deallocated. That means the variable is known only within the block:

#### Testing for Equality or Order

You can use strcmp() to test C-style strings for equality or order. The following expression is true if str1 and str2 are identical:
`strcmp(str1,str2) == 0`

The expressions
`strcmp(str1, str2) != 0`

and
`strcmp(str1, str2)`

are true if `str1` and `str2` are not identical. The following expression is true if `str1` precedes `str2`:
`strcmp(str1,str2) < 0`

And the following expression is true if str1 follows str2:
`strcmp(str1, str2) > 0`

Thus, the `strcmp`() function can play the role of the `==`,`!=`, `<`, and `>` operators, depending on how you set up a test condition.

#### string

The way the string class overloads the != operator allows you to use it as long as at least one of the operands is a string object; the remaining operand can be either a string object or a C-style string.
The string class design allows you to use a string object as a single entity, as in the relational test expression, or as an aggregate object for which you can use array notation to extract individual characters.

#### loop

Keep in mind the following guidelines when you design a loop:
• Identify the condition that terminates loop execution.
• Initialize that condition before the first test.
• Update the condition in each loop cycle before the condition is tested again.
One nice thing about for loops is that their structure provides a place to implement these three guidelines, thus helping you to remember to do so. But these guidelines apply to a while loop, too.

#### Type Aliases

`typedef typeName aliasName;`

### Type skill

- In general, writing clear, easily understood code is a more useful goal than demonstrating the ability to exploit obscure features of the language.

- You can visualize `maxtemps` as four rows of five numbers each. The term `{94, 98, 87, 103, 101}` initializes the first row, represented `bymaxtemps[0]`. As a matter of style, placing each row of data on its own line, if possible, makes the data easier to read.

EOF

```C++
while (cin.get(ch))  // while input is successful
{
    ...              // do stuff
}
```

![1541162451158](E:\icodeworld.github.io\os_lab\c++ Primer Plus(sixth)\assets\1541162451158.png)

#### Using a Two-Dimensional Array

If you intended for the strings to be modifiable, you would omit the `const` qualifier. This form uses the same initializer list and the same `for` loop display code as the other two forms. If you want modifiable strings, the automatic sizing feature of the `string` class makes this approach more convenient to use than the two-dimensional array approach.

#### Summary

Many programs read text input or text files character-by-character. The `istream` class provides several ways to do this. If `ch` is a type char variable, the following statement reads the next input character into `ch`:
`cin >> ch;`

However, it skips over spaces, newlines, and tabs. The following member function call reads the next input character, regardless of its value, and places it in `ch`:
`cin.get(ch);`

The member function call `cin.get()` returns the next input character, including spaces, newlines, and tabs, so it can be used as follows:
`ch = cin.get();`

The `cin.get(char)` member function call reports encountering the EOF condition by returning a value with the `bool` conversion of `false`, whereas the `cin.get()` member function call reports the EOF by returning the value EOF, which is defined in the `iostream` file.
A nested loop is a loop within a loop. Nested loops provide a natural way to process two-dimensional arrays.

## Chapter Review

1. What’s the difference between an entry-condition loop and an exit-condition loop? Which kind is each of the C++ loops?

   An entry-condition loop evaluates a test expression before entering the body of the loop. If the condition is initially false, the loop never executes its body. An exit-condition loop evaluates a test expression after processing the body of the loop. Thus, the loop body is executed once, even if the test expression is initially false. The for and while loops are entry-condition loops, and the do while loop is an exit-condition loop.

2. What would the following code fragment print if it were part of a valid program?

  ```c++
  int i;
  for (i = 0; i < 5; i++)
     cout << i;
     cout << endl;
  ```

  It would print the following:

  `01234`

3. What would the following code fragment print if it were part of a valid program?

  ```c++
  int j;
  for (j = 0; j < 11; j += 3)
     cout << j;
  cout << endl << j << endl;
  ```

  It would print the following:

  `0369`

  `12`

4. What would the following code fragment print if it were part of a valid program?

  ```c++
  int j = 5;
  while ( ++j < 9)
     cout << j++ << endl;
  ```

  It would print the following:

  `6`

  `8`

5. What would the following code fragment print if it were part of a valid program?

  ```
  int k = 8;
  do
     cout <<" k = " << k << endl;
  while (k++ < 5);
  ```

  It would print the following:

  `8`

6. Write a for loop that prints the values 1 2 4 8 16 32 64 by increasing the value of a counting variable by a factor of two in each cycle.

   ```c++
   for (int i = 1; i < 128; i = i * 2)
   	cout << i << endl;
   
   ```

7. How do you make a loop body include more than one statement?

   You enclose the statements within paired braces to form a single compound statement, or block.

8. Is the following statement valid? If not, why not? If so, what does it do?

  ```c++
  int x = (1,024);	
  // valid  equal to x = 024 = 20
  
  What about the following?
  int y;
  y = 1,024;
  // valid  equal to y = 1;
  ```

9. How does `cin>>ch` differ from `cin.get(ch)` and `ch=cin.get()` in how it views input?

   The `cin >> ch` form skips over spaces, newlines, and tabs when it encounters them. The other two forms read those characters.

## Programming Exercises

1. Write a program that requests the user to enter two integers. The program should then calculate and report the sum of all the integers between and including the two integers. At this point, assume that the smaller integer is entered first. For example, if the user enters 2 and 9, the program should report that the sum of all the integers from 2 through 9 is 44.

   ```c++
   #include <iostream>
   int main()
   {
   	using namespace std;
   	int less;
   	int more;
   	int sum = 0;
   	cin >> less;
   	cin >> more;
   	for (int i = less; i <= more; i++)
   		sum += i;
   	cout << "the sum of all the integers from " << less << " through " << more << " is " << sum;
   	return 0;
   }
   ```

2. Redo Listing 5.4 using a type array object instead of a built-in array and type long double instead of long long. Find the value of 100!

   ```c++
   // formore.cpp -- more looping with for
   #include <iostream>
   #include <array>
   const int Size = 101;
   int main()
   {
    	long double factorials[Size];
   	factorials[1] = factorials[0] = 1LL;
   	for (int i = 2; i < Size; i++)
   		factorials[i] = i * factorials[i-1];
   	for (int i = 0; i < Size; i++)
   		std::cout << i << "! = " << factorials[i] << std::endl;
   	return 0;
   }
   ```

3. Write a program that asks the user to type in numbers. After each entry, the program should report the cumulative sum of the entries to date. The program should terminate when the user enters 0.

   ```c++
   // formore.cpp -- more looping with for
   #include <iostream>
   int main()
   {
   	using namespace std;
   	double sum = 0;
   	double input;
   	do
   	{
   		cout << "Enter number: ";
   		cin >> input;
   		sum += input;
   		cout << "The sum is: " << sum << endl;
   	}
   	while (input != 0);
   	return 0;
   }
   ```

4. Daphne invests $100 at 10% simple interest. That is, every year, the investment earns 10% of the original investment, or $10 each and every year:
  interest = 0.10 × original balance
  At the same time, Cleo invests $100 at 5% compound interest. That is, interest is 5% of the current balance, including previous additions of interest:
  interest = 0.05 × current balance
  Cleo earns 5% of $100 the first year, giving her $105. The next year she earns 5% of $105, or $5.25, and so on. Write a program that finds how many years it takes for the value of Cleo’s investment to exceed the value of Daphne’s investment and then displays the value of both investments at that time.

  ```c++
  #include <iostream>
  const int Value = 100;
  int main()
  {
  	using namespace std;
  	float da = Value;
  	float cl = Value;
  	int year = 0;
  	while (cl <= da)
  	{
  		da += Value * 0.10;
  		cl += cl * 0.05;
  		++ year;
  	}
  	cout << "It takes " << year << " years\n"
  		 << "Daphne's investment value is: " << da << endl
  		 << "Cleo's investment value is: " << cl;
  	return 0;
  }
  
  ```

5. You sell the book C++ for Fools. Write a program that has you enter a year’s worth of monthly sales (in terms of number of books, not of money). The program should use a loop to prompt you by month, using an array of char * (or an array of string objects, if you prefer) initialized to the month strings and storing the input data in an array of int. Then, the program should find the sum of the array contents and report the total sales for the year.

   ```c++
   #include <iostream>
   const int Months = 12;
   int main()
   {
   	using namespace std;
   	string year[Months] = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec"};
   	int sale[Months];
   	int sum = 0;
   	for (int i = 0; i < Months; ++i)
   	{
   		cout << "Enter " << year[i] << " sales: ";
   		cin >> sale[i];
   		sum += sale[i];
   	}
   	cout << "The total sales for the year is: " << sum;
   }
   ```

6. Do Programming Exercise 5 but use a two-dimensional array to store input for 3 years of monthly sales. Report the total sales for each individual year and for the combined years.

   ```c++
   #include <iostream>
   const int Months = 12;
   const int Years = 3;
   const int Sum = 3;
   int main()
   {
   	using namespace std;
   	const char * yearyears[Years] =
   	{
   		"First year",
   		"Second year",
   		"Third year"
   	};
   	string yearr[Months] = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sept","Oct","Nov","Dec"};
   	int sale[Years][Months];
   	int sum[Sum];
   
   	cout << "Sales for 1 - 3 years\n\n";
   	for (int year = 0; year < Years; ++year)
   	{
   		sum[year] = 0;
   		cout << yearyears[year] << ":\n";
   		for (int month = 0; month < Months; ++month)
   		{
   			cout << "\tEnter " << yearr[month] << " sales: ";
   			cin >> sale[year][month];
   			sum[year] += sale[year][month];
   		}
   		cout << "The total sales for " << yearyears[year] << " is: " << sum[year] << endl;
   	}
   	cout << "\nThe total sales for " << yearyears[0] << " is: " << sum[0] << endl;
   	cout << "The total sales for " << yearyears[1] << " is: " << sum[1] << endl;
   	cout << "The total sales for " << yearyears[2] << " is: " << sum[2] << endl;
   	cout << "The total sales for three years is: " << sum[0] + sum[1] + sum[2];
   }
   ```

7. Design a structure called car that holds the following information about an automobile: its make, as a string in a character array or in a string object, and the year it was built, as an integer. Write a program that asks the user how many cars to catalog. The program should then use new to create a dynamic array of that many car structures. Next, it should prompt the user to input the make (which might consist of more than one word) and year information for each structure. Note that this requires some care because it alternates reading strings with numeric data (see Chapter 4). Finally, it should display the contents of each structure. A sample run should look something like the following:

  ```c++
  How many cars do you wish to catalog? 2
  Car #1:
  Please enter the make: Hudson Hornet
  Please enter the year made: 1952
  Car #2:
  Please enter the make: Kaiser
  Please enter the year made: 1951
  Here is your collection:
  1952 Hudson Hornet
  1951 Kaiser
  ```

  ```c++
  #include <iostream>
  #include <string>
  #include <cstring>
  struct car
  {
  	std::string make;
  	int year;
  };
  int main()
  {
  	using namespace std;
  	int numbers;
  	
  	cout << "How many cars do you wish to catalog? ";
  	cin >> numbers;
  	cin.get();
   	car * pt_car = new car [numbers];
   	
  	for (int i = 0; i < numbers; ++i)
  	{
  		cout << "Car #" << i+1 << ":\n";
  		cout << "Please enter the make: ";
  		getline(cin, (pt_car + i)->make);
  		cout << "Please enter the year made: ";
  	 	(cin >> (pt_car + i)->year).get();
  	};
  	cout << "Here is your colletion:\n";
  	for (int i = 0; i < numbers; ++i)
  		cout << (pt_car + 1)->year << " " << (pt_car + i)->make << " " << endl;
  	delete [] pt_car;
  	return 0;
  }
  ```

8. Write a program that uses an array of char and a loop to read one word at a time until the word done is entered. The program should then report the number of words entered (not counting done). A sample run could look like this:

   ```c++
   Enter words (to stop, type the word done):
   anteater birthday category dumpster
   envy finagle geometry done for sure
   You entered a total of 7 words.
   ```

   You should include the `cstring` header file and use the `strcmp()` function to make the comparison test.

9. Write a program that matches the description of the program in Programming Exercise 8, but use a string class object instead of an array. Include the string header file and use a relational operator to make the comparison test.

10. Write a program using nested loops that asks the user to enter a value for the number of rows to display. It should then display that many rows of asterisks, with one asterisk in the first row, two in the second row, and so on. For each row, the asterisks are preceded by the number of periods needed to make all the rows display a total number of characters equal to the number of rows. A sample run would look like this:

    ```c++
    Enter number of rows: 5
    ....*
    ...**
    ..***
    .****
    *****
    ```

    ```c++
    #include <iostream>
    int main()
    {
    	using namespace std;
    	int row;
    	cout << "Enter number of rows: ";
    	cin >> row;
    	char maxtemp[row][row];
    	
    	// store the 2-D arrays
    	for (int i = 0; i < row; ++i)
    	{
    		for (int j = 0; j < i + 1; ++j)
    			maxtemp[i][row - 1 - j] = '*';
    		for (int k = 0; k < row - 1 - i; ++k)
    			maxtemp[i][k] = '.';
    	}
    	
    	// print the result
    	for (int i = 0; i < row; ++i)
    	{
    		for (int j = 0; j < row ; ++j)
    			cout << maxtemp[i][j];
    		cout << endl;
    	}
    	return 0;
    }
    ```
