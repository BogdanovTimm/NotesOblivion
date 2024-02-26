                # What it services?

You specify a docker-image to use with `image:` keyword.
Additionaly, you may specify another Docker-image to use with `service:` keyword:

    ```YAML
    Jobname:
    image: ^imagename^
    stage: ^stagename^
    services:
        - name: ^imagename2^
        alias: ^imagename2 alias^
    script:
        - echo "Hello world!"
    ```