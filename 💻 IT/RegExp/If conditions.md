#                  Find X is there is Y (not including Y)

`(?<!)(?<=dog )cat(?! dog| fox)` - matches only **cat** if:
- `?<=` means that there must be a `dog ` before it
- `?!` means that there must not be a `dog ` or `fox ` after it

#                  Find X is there is Y (including Y)

`(dog )*cat` - finds `cat` only if line starts with a `dog` (not including `dog`)

#               Everything till X

`^[^X]+`