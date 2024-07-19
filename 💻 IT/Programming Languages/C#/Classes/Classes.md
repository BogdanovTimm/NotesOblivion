#                  Modificators

##                 `internal` vs `public`

- `internal` (default one) - this class is shown only in current solution
- `public` - this class is shown everywhere

This:
```C#
class ClassName {

}
```

is same as this:

```C#
internal class ClassName {

}
```

##                 `static`

- You can't create non-`static` variables
- You cna't create non-`static` funciotns
- You can't create children for this class
- You can't create instance of this class