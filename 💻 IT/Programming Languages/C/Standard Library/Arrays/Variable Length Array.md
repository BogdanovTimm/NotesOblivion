#                  Do not

- Do not `goto PLACE_AFTER_DECLARING_VLA` - actually, you can't do that. But compiler do not say why.

#                  What it is

Variable Length Array (VLA) is an array which size is not a variable (it does not matter that it is defined a line above as a constant number).

