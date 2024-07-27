```Dockerfile
FROM node:18-slim AS node

FROM node AS build
    SHELL [ "/bin/sh", "-eu", "-c" ]
    WORKDIR /build
    COPY src/ src/
    COPY public/ public/
    COPY package.json package-lock.json next.config.js tsconfig.json ./
    RUN \
        npm install \
        && npx next build \
        && cp --recursive .next/standalone /app \
        && cp --recursive public /app/public \
        && cp --recursive .next/static /app/.next/static

FROM node AS run
    ARG USER=user
    ARG HOME=/app
    ARG UID=1001
    ARG GID=1001
    RUN \
        addgroup --gid "${GID}" "${USER}" \
        && adduser --disabled-password --gecos "" \
        --home "${HOME}" --ingroup "${USER}" --uid "${UID}" "${USER}"
    WORKDIR ${HOME}
    COPY --from=build /app/ ./
    USER ${USER}
    ENV PORT="3000"
    ENV HOSTNAME="0.0.0.0"
    ENV NODE_ENV="production"
    EXPOSE ${PORT}/tcp
    ENTRYPOINT [ "node", "--", "/app/server.js" ]
```