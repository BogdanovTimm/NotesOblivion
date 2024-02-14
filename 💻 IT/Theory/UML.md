# Generalization

Parent-Child:

```java
ParentClass <|----- ChildClass
```

# Realization

Interface-ClassThatImplementsInterface:

```java
Interface <|- - - ClassThatImplementsInterface
```

# Aggregation/Composition

Class1 has Class2 instances in itself:

```java
Class1 <>----- Class2
```

# Dependency

Class1 calls some method in Class2

```java
Class1 -----> Class2
```