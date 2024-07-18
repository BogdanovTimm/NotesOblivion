#                  Types of float

Types of float:
- `float` - `123.5F` to force compiler to treat number as `float` . Single-prescision
- `double` - Double-prescision
- `long double` - `123.5L` to force compiler to treat number as `long double`. Extended-prescision
- `float_Complex`
- `double_Complex`
- `longdouble_Complex`









#                  float

Float consist of `mantissa * 2^exponent`. Mantissa sometimes called fraction.
For example:
- `120.5`         - human readable
- `1.205000e+02`  - how it may be represented to PC.
- `1.205 * 10^2`  - what this representation means
Second example:
- `120.5`         - human readable
- `1205.000e-01`  - how it may be represented to PC.
- `1.205 * 10^2`  - what this representation means
As you might see: 
- e+02 means that point need to be transferred for 2 digits on right.
- e-01 means that point need to be transferred for 2 digits on left.







#                  double

`double` is a big `float`
`DBL_MIN` is the smallest number that is strictly greater than 0.0;
the smallest negative double value is `-DBL_MAX`









#                  Max and Min values

Max and min values are unique for 16bit, 32bit and 64 bit processors.
Use `<float.h>` to find the varibles that describes max and min values for the processor, on which C programm is ran.