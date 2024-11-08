# What it is?

You can build binaries using `docker build`









# Commands

1) Create Dokcerifle:
    ```Dockerfile
    # syntax=docker/dockerfile:1
    FROM rust:alpine AS BuildStage
    WORKDIR /src
    COPY <<EOT your_program.rs
    fn main() {
        println!("Hello World!");
    }
    EOT
    RUN rustc -o /path/to/save/compiled_binary your_program.rs
    FROM scratch
    COPY --from=BuildStage /path/to/save/compiled_binary /
    ENTRYPOINT ["/compiled_binary"]
    ```
2) `docker build    --output=.    .`