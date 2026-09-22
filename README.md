# Yakima

Yakima is a fork of [Fortevom](https://github.com/werSquared/fortevom).

Yakima takes a more expressive approach compared to Fortevom, as well as being a bit more modern with the syntax. Some examples include:

```
for 3 times do
end
```

As opposed to:

```
for let int i = 0, i > 3, i++ do
end
```

Another example:

```
fn someFunction() returns string:
end
```

Versus:

```
fn someFunction() => string:
end
```

# Syntax

All expressions must end with a semicolon.

Variable declarations:

`<type> variable = value;`

Example:

`i32 weight = 46;`

The types will be mentioned later.

You can alternatively declare a variable using type inferrence:

`infer number = 96;`

If you plan on compiling Yakima into PHP, you can optionally omit the type entirely because it's purely cosmetic. This isn't advised, however, if you are targeting C#.

For example:

`number = 2004`

Comments are initiated with the ° (degree) symbol. On macOS, you can get this by pressing option-shift-8.
Unicode: U+00B0

`° This is a comment `

Writing to STDOUT:

`write_output("Helsinki");`

Alternatively, you can use `echo`. Echo is a keyword, therefore it does not require parentheses:

`echo "Stockholm"`

Reading from STDIN:

`read_stdin();`

Conditionals:

Note: unlike Fortevom, Yakima does not use `=/=` for the "not equal to" operator; it uses the traditional `!=` symbol.

Conditional blocks must be closed with ends

```
if condition then 
  ° ...
alternatively condition then
  ° ...
otherwise do 
   ° ...
end
```

Alternatively is the equivalent of elsif, elseif, or elif;
Otherwise is the equivalent of else.

You can also use the alternate inline conditional. This has the exact same syntax as Ruby:

`if <condition> then <result> end`

There are also shorthands for evaluating multiple variables against a value:

`either var1 var 2 == value` 

This is a shortcut for `if var1 == value or var2 == value`

Quick note: Yakima uses `or` like Python does; it is the equivalent of `||` in most other languages -- 
same with `and`; it is the equivalent of `&&`


`if var1 and var2 == value then ...` 

This is the equivalent of `if var1 == value and var2 == value`


`if var1 == value and var2 doesnt then ...`

This is the equivalent of `if var1 == value and var2 != value`



Functions:

Functions are declared using the `fn` keyword:

You must declare a return type

```
fn functionNAME() => returntype:
  <logic>
end
```

Yakima uses toggleCASE by convention; Each word alternates between no caps and all caps.

If your function takes arguments, those arguments need a type:

```
fn someFUNCTION(string argument, bool argumentTWO) => string:
  <logic>
end
```

If you want any type of argument, then you can use the type `any`:

```
fn someFUNCTION(any argument, any argumentTWO) => string:
  <logic>
end
```

Types

Here is the list of types available in Yakima:
- uint
- int
- boolean
- float
- string
- char
- obj
- any/inferred

Loops:

```
while condition do
  ° stuff
end
```
```
for let int i = 0, condition, i++ do
  ° stuff
end
```

```
for thing in things do 
  ° stuff
end 
```

Imports:

`import <thing>`

Alternatively, you can import a specific thing:

`from <folderORfile> import <thing>`

Arrays:

`array.length;` => returns the amount of items in an array

`array.find(x)` => returns index of x

`array.pushTAIL(item);` => explains itself

`array.pushHEAD(item);` => pushes an item at the very first index

`array.indexPUSH(item, i);` => pushes item at index i 

`array[i]` => access index i

`array.head` => first index

`array.tail` => last index

Objects:

Objects are declared using the obj type and curly brackets.

Keys and values are separated by the `==>` symbol.

```
obj object = {
  "key" ==> value 
}
```

Error handling:

```
attempt {
  ° error-prone code
}
when EXCEPTIONcode {
  ° what to do if it breaks
}
```

Purified using [Murman](https://github.com/Centurion774477/Murman)
