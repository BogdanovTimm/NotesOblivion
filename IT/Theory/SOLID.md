# Single Responsibility

1 Class should should has methods that do only 1 thing.

# Open Closed

Use Interfaces, so when you need to add something you just add another Interface, instead of changing your code.

# Liskov Substitution

If class A is a subtype of class B, we should be able to replace B with A without disrupting the behavior of our program:
- `ClassThatImplementsInterface` must define all methods from `Interface` 
- `ChildClass` can't override method from `ParentClass` to be less visible (from `public` to `private`) - only to be more visible (from `private` to `public`)

# Interface Segregation

Each Interface should be small enough so all Classes that implements it will not have unnecessary empty methods.

# Dependency Inversion

Classes must has Interfaces in them, not concreate classes.