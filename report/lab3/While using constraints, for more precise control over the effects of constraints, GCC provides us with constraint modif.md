## 5. [Extended Asm.](http://www.ibiblio.org/gferg/ldp/GCC-Inline-Assembly-HOWTO.html#toc5)

In basic inline assembly, we had only instructions. In extended assembly, we can also specify the operands. It allows us to specify the input registers, output registers and a list of clobbered registers. It is not mandatory to specify the registers to use, we can leave that head ache to GCC and that probably fit into GCC’s optimization scheme better. Anyway the basic format is:



> ```c
>        asm ( assembler template            
>            : output operands                  /* optional */            
>            : input operands                   /* optional */           
>            : list of clobbered registers      /* optional */          
>            ); 
> ```



The assembler template consists of assembly instructions. Each operand is described by an operand-constraint string followed by the C expression in parentheses. A colon separates the assembler template from the first output operand and another separates the last output operand from the first input, if any. Commas separate the operands within each group. The total number of operands is limited to ten or to the maximum number of operands in any instruction pattern in the machine description, whichever is greater.



If there are no output operands but there are input operands, you must place two consecutive colons surrounding the place where the output operands would go.



Example:

> ```c
>         asm ("cld\n\t"             
>             "rep\n\t"             
>             "stosl"             
>             : /* no output registers */             
>             : "c" (count), "a" (fill_value), "D" (dest)             
>             : "%ecx", "%edi"              
>             ); 
> ```



Now, what does this code do? The above inline fills the `fill_value` `count` times to the location pointed to by the register `edi`. It also says to gcc that, the contents of registers `eax` and `edi` are no longer valid. Let us see one more example to make things more clearer.

> ```c
>                  int a=10, b;        
>                  asm ("movl %1, %%eax;               
>                      movl %%eax, %0;"             
>                      :"=r"(b)        /* output */             
>                      :"r"(a)         /* input */              
>                      :"%eax"         /* clobbered register */          
>                      );        
> ```



Here what we did is we made the value of ’b’ equal to that of ’a’ using assembly instructions. Some points of interest are:



- "b" is the output operand, referred to by %0 and "a" is the input operand, referred to by %1.
- "r" is a constraint on the operands. We’ll see constraints in detail later. For the time being, "r" says to GCC to use any register for storing the operands. output operand constraint should have a constraint modifier "=". And this modifier says that it is the output operand and is write-only.
- There are two %’s prefixed to the register name. This helps GCC to distinguish between the operands and registers. operands have a single % as prefix.
- The clobbered register %eax after the third colon tells GCC that the value of %eax is to be modified inside "asm", so GCC won’t use this register to store any other value.



When the execution of "asm" is complete, "b" will reflect the updated value, as it is specified as an output operand. In other words, the change made to "b" inside "asm" is supposed to be reflected outside the "asm".



Now we may look each field in detail.



## 5.1 Assembler Template.

The assembler template contains the set of assembly instructions that gets inserted inside the C program. The format is like: either each instruction should be enclosed within double quotes, or the entire group of instructions should be within double quotes. Each instruction should also end with a delimiter. The valid delimiters are newline(\n) and semicolon(;). ’\n’ may be followed by a tab(\t). We know the reason of newline/tab, right?. Operands corresponding to the C expressions are represented by %0, %1 ... etc.



## 5.2 Operands.

C expressions serve as operands for the assembly instructions inside "asm". Each operand is written as first an operand constraint in double quotes. For output operands, there’ll be a constraint modifier also within the quotes and then follows the C expression which stands for the operand. ie,



"constraint" (C expression) is the general form. For output operands an additional modifier will be there. Constraints are primarily used to decide the addressing modes for operands. They are also used in specifying the registers to be used.



If we use more than one operand, they are separated by comma.



In the assembler template, each operand is referenced by numbers. Numbering is done as follows. If there are a total of n operands (both input and output inclusive), then the first output operand is numbered 0, continuing in increasing order, and the last input operand is numbered n-1. The maximum number of operands is as we saw in the previous section.



Output operand expressions must be lvalues. The input operands are not restricted like this. They may be expressions. The extended asm feature is most often used for machine instructions the compiler itself does not know as existing ;-). If the output expression cannot be directly addressed (for example, it is a bit-field), our constraint must allow a register. In that case, GCC will use the register as the output of the asm, and then store that register contents into the output.



As stated above, ordinary output operands must be write-only; GCC will assume that the values in these operands before the instruction are dead and need not be generated. Extended asm also supports input-output or read-write operands.



So now we concentrate on some examples. We want to multiply a number by 5. For that we use the instruction `lea`.



> ```c
>         asm ("leal (%1,%1,4), %0"             
>             : "=r" (five_times_x)              
>             : "r" (x)              
>             ); 
> ```



Here our input is in ’x’. We didn’t specify the register to be used. GCC will choose some register for input, one for output and does what we desired. If we want the input and output to reside in the same register, we can instruct GCC to do so. Here we use those types of read-write operands. By specifying proper constraints, here we do it.



> ```c
>         asm ("leal (%0,%0,4), %0"             
>             : "=r" (five_times_x)           
>             : "0" (x)              
>             ); 
> ```



Now the input and output operands are in the same register. But we don’t know which register. Now if we want to specify that also, there is a way.

> ```c
>         asm ("leal (%%ecx,%%ecx,4), %%ecx"           
>         : "=c" (x)         
>         : "c" (x)              
>         ); 
> ```



In all the three examples above, we didn’t put any register to the clobber list. why? In the first two examples, GCC decides the registers and it knows what changes happen. In the last one, we don’t have to put `ecx` on the c lobberlist, gcc knows it goes into x. Therefore, since it can know the value of `ecx`, it isn’t considered clobbered.





## 5.3 Clobber List.

Some instructions clobber some hardware registers. We have to list those registers in the clobber-list, ie the field after the third ’**:**’ in the asm function. This is to inform gcc that we will use and modify them ourselves. So gcc will not assume that the values it loads into these registers will be valid. We shoudn’t list the input and output registers in this list. Because, gcc knows that "asm" uses them (because they are specified explicitly as constraints). If the instructions use any other registers, implicitly or explicitly (and the registers are not present either in input or in the output constraint list), then those registers have to be specified in the clobbered list.



If our instruction can alter the condition code register, we have to add "cc" to the list of clobbered registers.



If our instruction modifies memory in an unpredictable fashion, add "memory" to the list of clobbered registers. This will cause GCC to not keep memory values cached in registers across the assembler instruction. We also have to add the **volatile** keyword if the memory affected is not listed in the inputs or outputs of the asm.



We can read and write the clobbered registers as many times as we like. Consider the example of multiple instructions in a template; it assumes the subroutine _foo accepts arguments in registers `eax` and `ecx`.



> ```c
>         asm ("movl %0,%%eax;       
>             movl %1,%%ecx;              
>             call _foo"             
>             : /* no outputs */            
>             : "g" (from), "g" (to)             
>             : "eax", "ecx"             
>             ); 
> ```



## 5.4 Volatile ...?

If you are familiar with kernel sources or some beautiful code like that, you must have seen many functions declared as `volatile` or `__volatile__` which follows an `asm` or `__asm__`. I mentioned earlier about the keywords `asm` and `__asm__`. So what is this `volatile`?



If our assembly statement must execute where we put it, (i.e. must not be moved out of a loop as an optimization), put the keyword `volatile` after asm and before the ()’s. So to keep it from moving, deleting and all, we declare it as

```
asm volatile ( ... : ... : ... : ...);
```



Use `__volatile__` when we have to be verymuch careful.



If our assembly is just for doing some calculations and doesn’t have any side effects, it’s better not to use the keyword `volatile`. Avoiding it helps gcc in optimizing the code and making it more beautiful.



In the section `Some Useful Recipes`, I have provided many examples for inline asm functions. There we can see the clobber-list in detail.



------

## 6. [More about constraints.](http://www.ibiblio.org/gferg/ldp/GCC-Inline-Assembly-HOWTO.html#toc6)

By this time, you might have understood that constraints have got a lot to do with inline assembly. But we’ve said little about constraints. Constraints can say whether an operand may be in a register, and which kinds of register; whether the operand can be a memory reference, and which kinds of address; whether the operand may be an immediate constant, and which possible values (ie range of values) it may have.... etc.



## 6.1 Commonly used constraints.

There are a number of constraints of which only a few are used frequently. We’ll have a look at those constraints.



1. Register operand constraint(r)

   When operands are specified using this constraint, they get stored in General Purpose Registers(GPR). Take the following example:



   `asm ("movl %%eax, %0\n" :"=r"(myval));`



   Here the variable myval is kept in a register, the value in register `eax` is copied onto that register, and the value of `myval` is updated into the memory from this register. When the "r" constraint is specified, gcc may keep the variable in any of the available GPRs. To specify the register, you must directly specify the register names by using specific register constraints. They are:



   > `+---+--------------------+ | r |    Register(s)     | +---+--------------------+ | a |   %eax, %ax, %al   | | b |   %ebx, %bx, %bl   | | c |   %ecx, %cx, %cl   | | d |   %edx, %dx, %dl   | | S |   %esi, %si        | | D |   %edi, %di        | +---+--------------------+ `

2. Memory operand constraint(m)

   When the operands are in the memory, any operations performed on them will occur directly in the memory location, as opposed to register constraints, which first store the value in a register to be modified and then write it back to the memory location. But register constraints are usually used only when they are absolutely necessary for an instruction or they significantly speed up the process. Memory constraints can be used most efficiently in cases where a C variable needs to be updated inside "asm" and you really don’t want to use a register to hold its value. For example, the value of idtr is stored in the memory location loc:

   `asm("sidt %0\n" : :"m"(loc));`

3. Matching(Digit) constraints

   In some cases, a single variable may serve as both the input and the output operand. Such cases may be specified in "asm" by using matching constraints.

   `asm ("incl %0" :"=a"(var):"0"(var));`



   We saw similar examples in operands subsection also. In this example for matching constraints, the register %eax is used as both the input and the output variable. var input is read to %eax and updated %eax is stored in var again after increment. "0" here specifies the same constraint as the 0th output variable. That is, it specifies that the output instance of var should be stored in %eax only. This constraint can be used:



   - In cases where input is read from a variable or the variable is modified and modification is written back to the same variable.
   - In cases where separate instances of input and output operands are not necessary.



   The most important effect of using matching restraints is that they lead to the efficient use of available registers.




Some other constraints used are:

1. "m" : A memory operand is allowed, with any kind of address that the machine supports in general.
2. "o" : A memory operand is allowed, but only if the address is offsettable. ie, adding a small offset to the address gives a valid address.
3. "V" : A memory operand that is not offsettable. In other words, anything that would fit the `m’ constraint but not the `o’constraint.
4. "i" : An immediate integer operand (one with constant value) is allowed. This includes symbolic constants whose values will be known only at assembly time.
5. "n" : An immediate integer operand with a known numeric value is allowed. Many systems cannot support assembly-time constants for operands less than a word wide. Constraints for these operands should use ’n’ rather than ’i’.
6. "g" : Any register, memory or immediate integer operand is allowed, except for registers that are not general registers.

Following constraints are x86 specific.



1. "r" : Register operand constraint, look table given above.
2. "q" : Registers a, b, c or d.
3. "I" : Constant in range 0 to 31 (for 32-bit shifts).
4. "J" : Constant in range 0 to 63 (for 64-bit shifts).
5. "K" : 0xff.
6. "L" : 0xffff.
7. "M" : 0, 1, 2, or 3 (shifts for lea instruction).
8. "N" : Constant in range 0 to 255 (for out instruction).
9. "f" : Floating point register
10. "t" : First (top of stack) floating point register
11. "u" : Second floating point register
12. "A" : Specifies the `a’ or `d’ registers. This is primarily useful for 64-bit integer values intended to be returned with the `d’ register holding the most significant bits and the `a’ register holding the least significant bits.



## 6.2 Constraint Modifiers.

While using constraints, for more precise control over the effects of constraints, GCC provides us with constraint modifiers. Mostly used constraint modifiers are

1. "=" : Means that this operand is write-only for this instruction; the previous value is discarded and replaced by output data.

2. "&" : Means that this operand is an earlyclobber operand, which is modified before the instruction is finished using the input operands. Therefore, this operand may not lie in a register that is used as an input operand or as part of any memory address. An input operand can be tied to an earlyclobber operand if its only use as an input occurs before the early result is written.

   The list and explanation of constraints is by no means complete. Examples can give a better understanding of the use and usage of inline asm. In the next section we’ll see some examples, there we’ll find more about clobber-lists and constraints.

While using constraints, for more precise control over the effects of constraints, GCC provides us with constraint modifiers. Mostly used constraint modifiers are

1. "=" : Means that this operand is write-only for this instruction; the previous value is discarded and replaced by output data.

2. "&" : Means that this operand is an earlyclobber operand, which is modified before the instruction is finished using the input operands. Therefore, this operand may not lie in a register that is used as an input operand or as part of any memory address. An input operand can be tied to an earlyclobber operand if its only use as an input occurs before the early result is written.

   The list and explanation of constraints is by no means complete. Examples can give a better understanding of the use and usage of inline asm. In the next section we’ll see some examples, there we’ll find more about clobber-lists and constraints.





## 7. Some Useful Recipes.

Now we have covered the basic theory about GCC inline assembly, now we shall concentrate on some simple examples. It is always handy to write inline asm functions as MACRO’s. We can see many asm functions in the kernel code. (/usr/src/linux/include/asm/*.h).

```c
int main(void){
    int foo = 10, bar =15;
    _asm_ _volatile_("addl	%%ebx,%%eax"
    				 :"=a"(foo)
    				 :"a"(foo), "b"(bar)
    				 );
    printf("foo+bar=%d\n",foo);
    return 0;
}
```

Here we insist GCC to store foo in %eax, bar in %ebx and we also want the result in %eax. The ’=’ sign shows that it is an output register. Now we can add an integer to a variable in some other way.

```c
_asm_ _volatile_(
				 " lock			;\n"
				 " addl %1,%0	;\n"
				 : "=m"	(my_var)
				 : "ir" (my_int), "m"(my_var)
				 :				/* no clobber-list */
				 
```

```c
_asm_ _volatile_( "decl %0; sete %1"
				 : "=m" (my_var), "=q" (cond)
				 : "m" (my_var)
				 : "memory"
				 );
/* the code is changing the contents of memory
```

```c
_asm_ _volatile_( "btsl %1,%0"
				 : "=m" (ADDR)
				 : "Ir" (pos)
				 : "cc"
				 );
```

```c
static inline char * strcpy(char * dest,const char *src)
{
    int d0, d1, d2;
    _asm_ _volatile_( "1:\tlodsb\n\t"
    				  "stosb\n\t"
    				  "testb %%al,%%al\n\t"
    				  "jne lb"
    				 :"=&S" (d0), "=&D" (d1), "=&a" (d2)
    				 :"0" (src),"1" (dest)
    				 :"memory");
    return dest;
}
```

