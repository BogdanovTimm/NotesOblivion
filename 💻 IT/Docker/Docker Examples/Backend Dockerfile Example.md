```Dockerfile
FROM python:3.11.6-slim-bookworm AS python_image

FROM python_image AS first_stage
    # v-- Set prefix for every [RUN]  --v
    #? WIth help of this line, [RUN ls] will be not just [ls], but [/bin/sh -eu -c ls]
    SHELL [ "/bin/sh", "-eu", "-c" ]
    # ^-- Set prefix for every [RUN] --^
  
    #? Equal to 'mkdir ./build && cd ./build'
    WORKDIR /build
  
    #?   folder related to Dockerfile                           folder within Docker container
    COPY src                                                    src/
    COPY tests                                                  tests/
    COPY Makefile poetry.lock pyproject.toml README.md          /build/

    #? Equal to '$(python -m ...)'
    RUN python -m pip install \
            --no-color --no-cache-dir --disable-pip-version-check \
            --no-python-version-warning --no-warn-script-location \
            --break-system-packages --progress-bar off \
            poetry setuptools wheel \
        && mkdir -p dist \
        && poetry export --without-hashes --format constraints.txt --output dist/constraints.txt \
        && poetry run python -m pip wheel --isolated --requirement dist/constraints.txt --wheel-dir dist/vendor \
        && poetry build --format wheel \
        && packages=$(find 'dist' 'dist/vendor' -maxdepth 1 -iname '*.whl' -exec realpath {} \; -print0 | xargs --null) \
        && python -m pip install \
            --isolated --no-index --no-color --no-cache-dir \
            --disable-pip-version-check --no-python-version-warning \
            --no-warn-script-location --no-deps --break-system-packages \
            --progress-bar off \
            ${packages}

#FROM python_image AS run
   # ARG USER=user
   # ARG HOME=/app
   # ARG UID=1001
   # ARG GID=1001
   # RUN addgroup --gid "${GID}" "${USER}" \
   #     && adduser --disabled-password --gecos "" \
   #     --home "${HOME}" --ingroup "${USER}" --uid "${UID}" "${USER}"
   # USER ${USER}
    ENV PORT="8080"
    EXPOSE ${PORT}/tcp
    #? Start of the application
    ENTRYPOINT [ "python", "-m", "counter_backend" ]
```