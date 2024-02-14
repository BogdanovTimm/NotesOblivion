#                What it is?

You may include other `.gitlab-ci.yml` files into your `.gitlab-ci.yml`







#                Code

##               File in the project

```YAML
include:
  - local: [/path/to/other-gitlab-ci].yml

[Job_name]:
  extends:
    - [.Hidden_job_name]
  [stage: publish]
  [needs:]
    [- job: Build Package]
      [artifacts: true]
```

##             File form another project

```YAML
include:
  - project: <gitlab_group>/<gitlab_project>
    ref: master
    file:
      - <path/to>/.gitlab-ci.yml



<Job_name>:
  extends:
    - <.Hidden_job_name>
  [stage: publish]
  [needs:]
    [- job: Build Package]
      [artifacts: true]
```