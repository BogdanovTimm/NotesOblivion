#                  What it is?

You may create a hiiden job that will be used as a base for another Jobds. 
Hidden Jobds are not runned by default.

```YAML
^.Hidden_Job^:
  variables:
    ^VARIABLE1^: ^Lorem Ipsum^

^Job name^:
  extends:
    - ^.Hidden_Job^
  script:
    - echo "$VARIABLE1"
```