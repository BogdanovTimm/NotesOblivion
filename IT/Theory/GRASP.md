# What it is?

Although GRASP means General Responsibility Assignment Software Patterns, it is not Design Patterns at all. It is a theoretical principles for writing applications.

# Information Expert

Only class that has some variable can change that variable.

# Creator

You need to create new instance of some Class only in a Class where it need to be used. You should not pass this instance as a parameter through some chain of method calls.

# Controller

You must have special classes that deals with everything that goes into application (HTTP-Requests, reading from a file, reading from a Database) and that goes out from the application (HTTP-Response, writing to a file, writing to a Database)

# Indirection

If `Class1` must work with `Class2` only via `InterfaceForClass2`

# Low Coupling

This:
```
Class1----->Class2
   | 
   +------->Class3
```

Must be changed to this:
```
Class1------>Class2----->Class3
```

# High Cohesion

One Class must do only 1 thing

# Polymorphism

If there is a lot of if-statements that chooses with which of 2 different `ClassToWork` - you need to create an Interface and `ClassThatImplementsInterface`. Now, this new Classes will work with this `ClassesToWork`:
So, this:
```
Class1----->ClassToWorkWith1
   | 
   +------->ClassToWorkWith2
```

Must be changed to this:
```
Class1----->CustomInterface------>ClassThatImplementsInterface1------>ClassToWorkWith1
                  |
                  +-------------->ClassThatImplementsInterface2------>ClassToWorkWith2
```

# Protected Variations

You need to work always thinking about whether changes will occur.

# Pure Fabrication

If you have some methods that need to be in one Class - you can create such a Class, even if this object is not represented in a real world.