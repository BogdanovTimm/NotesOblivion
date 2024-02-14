#            What it is?

It is an extension for GitLab Ci that allows you to reference yaml tags (butm because it is only for GitLab CI, it will not work in Ansible, for example).

Also, it is an alternative to [[Anchors]].







#               Code

```YAML
Job_name:
  image:
    name: $NODEJS_IMAGE
    entrypoint: [""]
 
Job_name2:
  image: !reference [Job_name1, image]
```