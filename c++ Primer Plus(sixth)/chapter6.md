[TOC]

## Unfamiliar points of knowledge

When you open an existing file for output, by default it is truncated to a length of zero bytes, so the contents are lost.

A Windows text file uses the carriage return character followed by a linefeed character to terminate a line of text. (The usual C++ text mode translates this combination to newline character when reading a file and reverses the translation when writing to a file.) Some text editors, such as the Metrowerks CodeWarrior IDE editor, don’t automatically add a this combination to the final line. Therefore, if you use such an editor, you need to press the Enter key after typing the final text and before exiting the file.

##### Summary

Programs and programming become more interesting when you introduce statements that guide the program through alternative actions. (Whether this also makes the programmer more interesting is a point you may wish to investigate.) C++ provides the if statement, the if else statement, and the switch statement as means for managing choices. The C++ if statement lets a program execute a statement or statement block conditionally. That is, the program executes the statement or block if a particular condition is met. The C++ if else statement lets a program select from two choices which statement or statement block to execute. You can append additional if else statements to such a statement to present a series of choices. The C++ switch statement directs the program to a particular case in a list of choices.
C++ also provides operators to help in decision making. Chapter 5 discusses the relational expressions, which compare two values. The if and if else statements typically use relational expressions as test conditions. By using C++’s logical operators (&&, ||, and !), you can combine or modify relational expressions to construct more elaborate tests. The conditional operator (?:) provides a compact way to choose from two values.
The cctype library of character functions provides a convenient and powerful set of tools for analyzing character input.
Loops and selection statements are useful tools for file I/O, which closely parallels console I/O. After you declare ifstream and ofstream objects and associate them with files, you can use these objects in the same manner you use cin and cout.
With C++’s loops and decision-making statements, you have the tools for writing interesting, intelligent, and powerful programs. But we’ve only begun to investigate the real powers of C++. Next, we’ll look at functions.

## Chapter Review

1. Consider the following two code fragments for counting spaces and newlines:

  ```c++
  1. // Version 1
  
  while (cin.get(ch))    // quit on eof
  {
        if (ch == ' ')
               spaces++;
        if (ch == '\n')
              newlines++;
  }
  
  // Version 2
  while (cin.get(ch))    // quit on eof
  {
        if (ch == ' ')
              spaces++;
        else if (ch == '\n')
              newlines++;
  }
  ```

  What advantages, if any, does the second form have over the first?

  Both versions give the same answers, but the if else version is more efficient. Consider what happens, for example, when `ch` is a space. Version 1, after incrementing spaces, tests whether the character is a newline. This wastes time because the program has already established that `ch` is a space and hence could not be a newline.Version 2, in the same situation, skips the newline test.

2. In `LIsting 6.2`, what is the effect of replacing `++ch` with `ch+1`?

   Both `++ch` and `ch + 1` have the same numerical value. But `++ch` is type char and prints as a character, while `ch + 1`, because it adds a char to an int, is type int and prints as a number.

3. Carefully consider the following program:

  ```c++
  #include <iostream>
  using namespace std;
  int main()
  {
   char ch;
   int ct1, ct2;
  
   ct1 = ct2 = 0;
   while ((ch = cin.get()) != '$')
   {
          cout << ch;
          ct1++;
          if (ch = '$')
              ct2++;
          cout << ch;
      }
      cout <<"ct1 = " << ct1 << ", ct2 = " << ct2 << "\n";
      return 0;
  }
  ```

  Suppose you provide the following input, pressing the Enter key at the end of each line:
  `Hi!`
  `Send $10 or $20 now!`

  What is the output? (Recall that input is buffered.)

  Because the program uses `ch = '$'` instead of `ch == '$'`, the combined input and output looks like this:

  ```
  Hi!
  H$i$!$
  $Send $10 or $20 now!
  S$e$n$d$ $ct1 = 9, ct2 = 9
  ```

  Each character is converted to the `$` character before being printed the second time. Also the value of the expression `ch = $` is the code for the `$` character, hence nonzero, hence true; so ct2 is incremented each time.

4. Construct logical expressions to represent the following conditions:

   ```c++
   a. weight is greater than or equal to 115 but less than 125.
   b. ch is q or Q.
   c. x is even but is not 26.
   d. x is even but is not a multiple of 26.
   e. donation is in the range 1,000–2,000 or guest is 1.
   f. ch is a lowercase letter or an uppercase letter. (Assume, as is true for ASCII, that lowercase letters are coded sequentially and that uppercase letters are coded sequentially but that there is a gap in the code between uppercase and lowercase.)
   ```

   ```c++
   weight >= 115 && weight < 125;
   ch == 'q' || ch = 'Q';
   x % 2 == 0 && x != 26;
   x % 2 == 0 && !(x % 26 == 0);
   donation >= 1000 && donation <= 2000 || guest == 1;
   (ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z');
   ```


5. In English, the statement “I will not not speak” means the same as “I will speak.” In C++, is !!x the same as x?

   Not necessarily. For example, if x is 10, then !x is 0 and !!x is 1. However, if x is a bool variable, then !!x is x

6. Construct a conditional expression that is equal to the absolute value of a variable. That is, if a variable x is positive, the value of the expression is just x, but if x is negative, the value of the expression is -x, which is positive.

   `(x >= 0)? x : -x;`

7. Rewrite the following fragment using switch:

  ```c++
  if (ch == 'A')
   a_grade++;
  else if (ch == 'B')
   b_grade++;
  else if (ch == 'C')
   c_grade++;
  else if (ch == 'D')
   d_grade++;
  else
   f_grade++;
  ```

  ```c++
  switch(ch)
  {
  	case 'A': a_grade++;
  			  break;
  	case 'B': b_grade++;
  			  break;
  	case 'C': c_grade++;
  			  break;
  	case 'D': d_grade++;
  			  break;
  	default:  f_grade++;
  			  break;
  }
  ```

8. In Listing 6.10, what advantage would there be in using character labels, such as a and c, instead of numbers for the menu choices and switch cases? (Hint: Think about what happens if the user types q in either case and what happens if the user types 5 in either case.)

   It's convenient for us to remember.

9. Consider the following code fragment:

  ```c++
  int line = 0;
  char ch;
  
  while (cin.get(ch))
  {
      if (ch == 'Q')
             break;
      if (ch != '\n')
             continue;
      line++;
  }
  ```

  Rewrite this code without using break or continue.

  ```c++
  	int line = 0;
  	char ch;
  
  	while ((ch = cin.get()) != 'Q')
  	{		// or cin.get(ch) && ch != 'Q'
  		if (ch == '\n')
  			line++;
  	}
  ```

## Programming Exercises

1. Write a program that reads keyboard input to the @ symbol and that echoes the input except for digits, converting each uppercase character to lowercase, and vice versa. (Don’t forget the `cctype` family.)

   ```c++
   #include <iostream>
   #include <cctype>
   using namespace std;
   
   int main()
   {
   	char ch;
   	while ((cin.get(ch)) && (ch != '@'))
   	{
   		if (isdigit(ch))
   		{
   			// do nothing
   		};
   		if (islower(ch))
   		{
   			ch = toupper(ch);
   			cout << ch;
   			continue;
   		}
   		if (isupper(ch))
   		{
   			ch = tolower(ch);
   			cout << ch;
   			continue;
   		}
   	}
   	return 0;
   }
   ```

2. Write a program that reads up to 10 donation values into an array of double. (Or, if you prefer, use an array template object.) The program should terminate input on non-numeric input. It should report the average of the numbers and also report how many numbers in the array are larger than the average.

   ```c++
   #include <iostream>
   #include <cctype>
   const int Max = 10;
   int main()
   {
   	using namespace std;
   	double donation[Max];
   	int i = 0;
   	while (i < Max && cin >> donation[i])
    	{
    		i++;
   	};
   // calculate
   	double average = 0.0;
   	for (int j = 0; j < i; j++)
   		average += donation[j];
   	average = average / i;
   	cout << "Average is: " << average << endl;
   
   	int more = 0;
   	for (int k = 0; k < i; k++)
   		if (donation[k] > average)
   			more++;
   	cout << more << endl;
   	cout << "Done.\n";
   	return 0;
   }
   ```

3. Write a precursor to a menu-driven program. The program should display a menu offering four choices, each labeled with a letter. If the user responds with a letter other than one of the four valid choices, the program should prompt the user to enter a valid response until the user complies. Then the program should use a switch to select a simple action based on the user’s selection. A program run could look something like this:

  ```
  Please enter one of the following choices:
  c) carnivore           p) pianist
  t) tree                g) game
  f
  Please enter a c, p, t, or g: q
  Please enter a c, p, t, or g: t
  A maple is a tree.
  ```

  ```c++
  #include <iostream>
  using namespace std;
  void showmenu();
  int main()
  {
  	showmenu();
  	char choices;
  	cout << "Please enter a c, p, t, or g: ";
  	while (true)
  	{
  		cin >> choices;
  		switch(choices)
  		{
  			
  			case 'c': cout << "A maple is a carnivore.\n";
  					  break;
  			case 'p': cout << "A maple is a pianist.\n";
  					  break;
  			case 't': cout << "A maple is a tree.\n";
  					  break;
  			case 'g': cout << "A maple is a game.\n";
  					  break;
  			default:  cout << "Please enter a c, p, t, or g: ";
  					  continue;
  		}
  	}
  	cout << "Bye!\n";
  	return 0;
  }
  
  void showmenu()
  {
  	cout << "Please enter one of the following choices:\n"
  		    "c) carnivore			p) pianist\n"
  			"t) tree				g) game\n";
  }
  ```


4. When you join the Benevolent Order of Programmers, you can be known at BOP meetings by your real name, your job title, or your secret BOP name. Write a program that can list members by real name, by job title, by secret name, or by a member’s preference. Base the program on the following structure:
  // Benevolent Order of Programmers name structure
  struct bop {
   char fullname[strsize]; // real name
   char title[strsize];    // job title
   char bopname[strsize];  // secret BOP name
   int preference;         // 0 = fullname, 1 = title, 2 = bopname
  };

  In the program, create a small array of such structures and initialize it to suitable values. Have the program run a loop that lets the user select from different alternatives:

  ```
  a. display by name     b. display by title
  c. display by bopname  d. display by preference
  q. quit
  ```

  Note that “display by preference” does not mean display the preference member; it means display the member corresponding to the preference number. For instance, if preference is 1, choice d would display the programmer’s job title. A sample run may look something like the following:

  ```
  Benevolent Order of Programmers Report
  a. display by name     b. display by title
  c. display by bopname  d. display by preference
  q. quit
  Enter your choice: a
  Wimp Macho
  Raki Rhodes
  Celia Laiter
  Hoppy Hipman
  Pat Hand
  Next choice: d
  Wimp Macho
  Junior Programmer
  MIPS
  Analyst Trainee
  LOOPY
  Next choice: q
  Bye!
  ```

  ```c++
  #include <iostream>
  using namespace std;
  const int Size = 5;
  const int strsize = 30;
  
  struct bop {
      char fullname[strsize];     // real name
      char title[strsize];       // job title
      char bopname[strsize];    // secret BOP name
      int preference;			 // 0 = fullname, 1 = title, 2 = bopname
  };							// Benevolent Order of Programmers name structure
  void showmenu();
  
  int main()
  {
  	showmenu();
  	char choice;
  
  	bop guests[Size] =
  	{
  		{"Hu jie", "Professor", "Tutu", 0},
  		{"Wang Lu", "graceful Wife", "Lulu", 1},
  		{"Jian cheng", "faithful friend", "CC", 2},
  		{"Xiao Hui", "forever friend", "HH", 1},
  		{"He Ke Yi", "good friend", "KH", 0}
  	};
  	cout << "Enter your choice: ";
  	cin >> choice;
  	while (choice != 'q')
  	{
  		switch(choice)
  		{
  			case 'a' :
  					 for (int i = 0; i < Size; i++)
  						cout << guests[i].fullname << endl;
  					 break;
  			case 'b' :
  					 for (int i = 0; i < Size; i++)
  						cout << guests[i].title << endl;
  					 break;
  			case 'c' :
  					 for (int i = 0; i < Size; i++)
  						cout << guests[i].bopname << endl;
  					 break;
  			case 'd' :
  					 for (int i = 0; i < Size; i++)
  					 {
  							if (guests[i].preference == 0)
  								cout << guests[i].fullname << endl;
  							if (guests[i].preference == 1)
  								cout << guests[i].title << endl;
  							if (guests[i].preference == 2)
  								cout << guests[i].bopname << endl;
  					 };
  					 break;
  			default: cout << "That's not a choice.\n";
  		}
  		showmenu();
  		cout << "Next choice: ";
  		cin >> choice;
  	}
  	cout << "Bye!\n";
  	return 0;
  }
  
  void showmenu()
  {
  	cout << "Benevolent Order of Programmers Report\n"
  			"a. display by name     b. display by title\n"
  			"c. display by bopname  d. display by preference\n"
  			"q. quit\n";
  }
  ```


5. The Kingdom of Neutronia, where the unit of currency is the tvarp, has the following income tax code:
  First 5,000 tvarps: 0% tax
  Next 10,000 tvarps: 10% tax

  Next 20,000 tvarps: 15% tax
  Tvarps after 35,000: 20% tax
  For example, someone earning 38,000 tvarps would owe 5,000 × 0.00 + 10,000 × 0.10 + 20,000 × 0.15 + 3,000 × 0.20, or 4,600 tvarps. Write a program that uses a loop to solicit incomes and to report tax owed. The loop should terminate when the user enters a negative number or non-numeric input.

6. Put together a program that keeps track of monetary contributions to the Society for the Preservation of Rightful Influence. It should ask the user to enter the number of contributors and then solicit the user to enter the name and contribution of each contributor. The information should be stored in a dynamically allocated array of structures. Each structure should have two members: a character array (or else a string object) to store the name and a double member to hold the amount of the contribution. After reading all the data, the program should display the names and amounts donated for all donors who contributed $10,000 or more. This list should be headed by the label Grand Patrons. After that, the program should list the remaining donors. That list should be headed Patrons. If there are no donors in one of the categories, the program should print the word “none.” Aside from displaying two categories, the program need do no sorting.

7. Write a program that reads input a word at a time until a lone q is entered. The program should then report the number of words that began with vowels, the number that began with consonants, and the number that fit neither of those categories. One approach is to use `isalpha()` to discriminate between words beginning with letters and those that don’t and then use an if or switch statement to further identify those passing the isalpha() test that begin with vowels. A sample run might look like this:

   ```
   Enter words (q to quit):
   The 12 awesome oxen ambled
   quietly across 15 meters of lawn. q
   5 words beginning with vowels
   4 words beginning with consonants
   2 others
   ```

8. Write a program that opens a text file, reads it character-by-character to the end of the file, and reports the number of characters in the file.

9. Do Programming Exercise 6 but modify it to get information from a file. The first item in the file should be the number of contributors, and the rest of the file should consist of pairs of lines, with the first line of each pair being a contributor’s name and the second line being a contribution. That is, the file should look like this:

  ```
  4
  Sam Stone
  2000
  Freida Flass
  100500
  Tammy Tubbs
  5000
  Rich Raptor
  55000
  ```
