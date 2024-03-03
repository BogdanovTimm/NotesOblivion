#                  Replace

##                 All occurences, case-sensitive

1. `Shift + ;`
2. `%s/RegExp to find/Replacing text/g` - `%` means that you will do it for every occurrence, not only for hte 1st one


###                 All occurences, case-sensitive, fast way

1. `/`
2. Enter you search pattern and check that it finds what you want
3. `Shift + ;`
4. `%s//Replacing text/g` - `%` means that you will do it for every occurrence, not only for hte 1st one

###                Get last search RegExp

You may get your last search RegExp pattern with:
1. `Ctrl + r`
2. `/`

###                Vim's RegExp:

Vim's RegExp is slight different from a standard one. For example, you need to use `\(\)` instead of `()` to create a group of characters.
Also, to usu logical OR, you need to use `\|` instead of standard `|`.

`\(Lorem\|Ipsum\)` - searches for ether 'Lorem' or 'Ipsum'








#                  Swap 1st and 2nd words

1. `Shift + ;`
2. `%s/\(RegExp for 1st word\) \(Regexp for 2nd word\)/\2 \1`