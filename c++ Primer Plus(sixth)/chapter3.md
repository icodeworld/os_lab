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
   short si = {80};
   unsigned int mi = {42110};
   long long hi = {3,000,000,000};
   ```

3. C++ provides no automatic safeguards to keep you from exceeding integer limits; you can use the climits header file to determine what the limits are.