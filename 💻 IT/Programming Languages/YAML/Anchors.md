#             What it is?

Anchors allows you to reuse block of code in .yaml files.

There is an alternative for this, but which works only with `Gitlab-CI`. See: [[reference]].







# Code

```YAML
#? Creating of anchor
car_details: &ANCHOR1
  make: Toyota  
  model: Camry  
  year: 2021  

#? Using anchor
new_car:  
  <<: *ANCHOR1
  color: White  
 
used_car:  
  <<: *ANCHOR1
  odometer_reading: 32410  
  condition: Good
```