# Structure


Your **repository** must contains:
- `.gitlab-ci.yml` - it is a file that describe what to do when someone pushes in a gitlab, pull, etc
- `.gitlab-ci-local-variables.yml` - contains default values for variables, that are used in `.gitlab-ci.yml`







#               Sequence

- **Stages** - runs sequently
- **Jobs within 1 Stage** - runs parallel
- `needs` - runs job right after the job in the `needs`