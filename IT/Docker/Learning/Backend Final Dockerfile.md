```Dockerfile
ARG PYTHON_VERSION="3.11.6"

ARG DEBIAN_VERSION="slim-bookworm"

  
  

FROM python:${PYTHON_VERSION}-${DEBIAN_VERSION} AS base

  

SHELL [ "/bin/sh", "-eu", "-c" ]

  

RUN \

  pip config set --global global.quiet 1 \

  ; pip config set --global global.no-color true \

  ; pip config set --global global.disable-pip-version-check true \

  ; pip config set --global global.no-python-version-warning false \

  ; pip config set --global install.progress-bar off \

  ; pip config set --global install.no-warn-script-location false \

  ; pip config set --global install.compile true \

  ; pip config set --global install.no-cache-dir true

  
  

FROM base AS build

  

WORKDIR /build

COPY dist/*.whl dist/

COPY dist/vendor dist/vendor

  

RUN \

  packages=$(find dist dist/vendor -maxdepth 1 -iname '*.whl' -exec realpath {} \; -print0 | xargs --null) \

  ; python -m venv /venv \

  ; . /venv/bin/activate \

  ; python -m pip install --isolated --no-index --no-deps $packages \

  ; rm -rf dist

  
  

FROM base

  

ARG USER="user"

ARG HOME="/app"

ARG UID="1000"

ARG GID="1000"

  

RUN \

  addgroup --gid "$GID" "$USER" \

  ; adduser --disabled-password --gecos "" --home "$HOME" --ingroup "$USER" --uid "$UID" "$USER" \

  ; printf '#!/bin/sh\n\n. /venv/bin/activate\nexec "$@"\n' >/entrypoint \

  ; chmod 0755 /entrypoint

  

COPY --from=build --chown=${USER}:${USER} /venv /venv

  

ENV PORT="8080"

  

USER $USER

WORKDIR $HOME

EXPOSE $PORT/tcp

ENTRYPOINT [ "/entrypoint" ]

CMD [ "server" ]
```