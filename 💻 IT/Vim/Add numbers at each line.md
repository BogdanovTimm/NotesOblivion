1. *(Optinal)* select lines if you want to add numbers only to a certain ones
2. `Shift + ;`
3. `s/^/\=(line('.')-line("'<")+42).'. '/` - where `42` is a first number and `'. '` is a text that will be added after a number