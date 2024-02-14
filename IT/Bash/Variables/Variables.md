#                  Inner RegEexp

```Bash
variable_null4=text4
variable5="abcdefghijklmnopqrstuvwxyz 123 abc123"
echo "${variable_null-text to be printed once if there is no such value}" # Prints given variable or given text if there is no such variable or it is equal to zero
echo "${variable_null2:=value to this variable}" # Prints given variable or create new variable if there is no such variable
#echo "${variable_null3:?text to be printed to error output}" # Prints given variable. If there is no such variable or it is equal to zero, prints given text to error output and stops this script
echo "${variable_null4:+text to be printed once if there is some value}"
echo "${variable5:3:5}" # Prints 5 characters from variable5 starting from 3rd character

echo "${variable_null}"
echo "${variable_null2}"
echo "${variable_null3}"
echo "${variable_null4}"

echo "${!variable@}" # Prints names of all variables that start with 'variable'
echo "${#variable5}" # Prints length of value of variable5
echo "${variable5#abc}" # Prints value of variable5 without 'abc' if value starts with 'abc'
echo "${variable5//123/CENSORED}" # Prints value of variable5 with '123' replaces by 'CENSORED' 
```