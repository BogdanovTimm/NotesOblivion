# syntax=docker/dockerfile:1     # Sets Docker syntax version
# escape=\                       # Sets Escape-Characher. [\] is a default one. Useful on Windows
# check=skip=JSONArgsRecommended # Sets which checks to skip
# check=error=true               # Sets whether to fail on failed check. Default is do nothing.
# ^----------------------------------------------------------------------------------------------- Pre-[docker build]









# v----------------------------------------------------------------------------------------------- [docker build]
# Like [ENV], but don't persist in [docker run]. To be used after [FROM] it must be reused after [FROM] (see below)
# May be rewritten using [docker build --build-arg xVARIABLE_THAT_EXISTS_DURING_BUILDx=xNEW_VALUEx]
# Do not use it to pass secrets! Use [RUN --mount=type=secret]
ARG    xVARIABLE_THAT_EXISTS_DURING_BUILDx=xDEFAULT_VALUE_THAT_MAY_BE_OWERWRITTENx 

# This can be used to build from scratch
FROM scratch

# Allows to use varible from [ARG] during [docker build] after [FROM]
ARG    xVARIABLE_THAT_EXISTS_DURING_BUILDx

# !!! DEPRECATED !!!
MAINTAINER 

# Same as if you do [suod -iu xUSERNAMEx]. So, you need to create a user and a group before using [USER xUSERx]!
USER    xUSERx:xGROUPx

# Sets Evironment-Variable that exists both during [docker build] and during [docker run]
# Environment-Variables may be rewritten using [docker run --env VARIABLE1=NEW_VALUE]
# In multi-stage builds, Environment-Variables are inherited from all previous builds.
# Also, if [ENV] and [ARG] variables has same name - then [ENV] variable will rewrite [ARG] variable
ENV    xVARIABLE1x=xVALUE1x

# Similar to [cd x/FOLDERx]. Use it instead of [cd xFOLDERx]
WORKDIR    x/FOLDERx

# Download files from HTTPS or git to the final Docker-Image.
# Use [wget] instead of [ADD] if you need to authorize to the website.
# If last parameter does not set filename [/only/path/] then name of a file will be inherited from original one
ADD    ["https://xWEBSITE.DOMEIN.COMx/xFILE.ZIPx",                       "x/PATH/IN/DOCKER/IMAGEx/"]
ADD    ["git@xYOUR.GITLAB.DOMAIN.COMx:xUSERx/xFILE_TO_DOWNLOAD.TXTx",    "x/PATH/IN/DOCKER/IMAGEx/"]

# Used to copy files to the Docker-Image from host on which [docker build] is executed or from previous Build-Stages
# If last parameter does not set filename [/only/path/] then name of a file will be inherited from original one
COPY    --chown xUSERx:xGROUPx             \
        --chown 777                        \
        ["x/PATH/ON/THIS/PC/TO/FILE.TXTx", \
         "x/PATH/IN/DOCKER/IMAGE/TO/FILE.TXTx"]

# You may write a file using Here-Doc:
COPY    <<-EOF    x/PATH/IN/DOCKER/IMAGEx
Hello ${VARIABLE1}!
EOF

# Allows you to change shell. It will affect how [RUN], [CMD] and [ENTRYPOINT] work
SHELL    ["/bin/sh",    "-c"]

# Run command within Docker-image during [docker build].
# If you need to use [RUN sudo xCOMMANDx], then use [RUN gosu xCOMMANDx]
RUN    command      parameter

# Used to copy files to the Docker-Image when you need them only once to run some command
RUN    --mount=type=bind,source=x/PATH/ON/THIS/PC/TO/FILE.TXTx,target=x/PATH/IN/DOCKER/IMAGE/TO/FILE.TXTx \
    xEXECUTABLE_THAT_NEEDS_FILEx x/PATH/IN/DOCKER/IMAGE/TO/FILE.TXTx

# Used to copy files to the Docker-Image when you need them only once to run some command and is is a secret
# You must pass the secret using [docker buildx build --secret id=xSECRET_NAMEx,src=x/PATH/ON/PCx]
RUN    --mount=type=secret,id=xSECRET_NAMEx,target=x/PATH/IN/DOCKER/IMAGE/TO/FILE.TXTx \
    xEXECUTABLE_THAT_NEEDS_FILEx x/PATH/IN/DOCKER/IMAGE/TO/FILE.TXTx

# To install something always combine [apt-get update && apt-get install -y xPACKAGEx]
# It is needed because of Docker-cache : if you use 2 same commands 2 times...
#      ...(e.g. [RUN apt-get update] and then it again) then second time it will not be run!
RUN    apt-get update && apt-get install -y xPACKAGEx

# Set pipefail if you use [|] in your commands:
RUN set -o pipefail && wget -O - https://some.site | wc -l > /number










# ^--------------------------------------------------------------------------- Child-[docker build]
# This instructions will be run right after somebody will do [FROM xTHIS_IMAGEx]
ONBUILD RUN echo "Oh, you have chosen me, it is so sweet..."
ONBUILD RUN rm -rf /
# ^--------------------------------------------------------------------------- Child-[docker build]
# ^----------------------------------------------------------------------------------------------- [docker build]









# v----------------------------------------------------------------------------------------------- [docker run]
# Same as if you do [suod -iu xUSERNAMEx]
USER    xUSERx:xGROUPx

# Similar to [cd x/FOLDERx]
WORKDIR    x/FOLDERx

# See full description above
ENV    xVARIABLE1x=xVALUE1x

# Use syncs folder within Docker-Image with folder on PC that runs [docker run xDOCEKR_IMAGEx]
# You need to set folder on the PC side when you run [docker run xDOCKER_IMAGEx]
VOLUME ["x/PATH/IN/DOCKER/IMAGEx"]

# Set metadata to Docker-Image
LABEL    "xVARIABLEx"="xVALUEx" 

# Informs Docker that 55555 port is used within Docker-Container
EXPOSE    55555/udp
EXPOSE    55555/tcp

# Do checks in given interval
HEALTHCHECK    --interval=5m    --timeout=3s \
  CMD    curl -f http://localhost/    ||    exit 1

# What Docker-Image would do when [docker run]. If there are more than 1 [CMD], then only last one will work
CMD    command    parameter1

# [ENTRYPOINT] + [CMD] is used to set what to execute each time [docker run xIMAGEx]
# [CMD] sets default argument that may be rewritten if you do [docker run xIMAGEx xNEW_ARGUMENTx]
# If more than 1 [ENTRYPOINT] then only the last one will be actually executed.
ENTRYPOINT    ["xEXECUTABLEx", "xDEFFAULT_ARGUMENT_THAT_CANNOT_BE_REWRITTENx"]
CMD           ["xDEFAULT_ARGUMENT_THAT_CAN_BE_REWRITTENx"]
# ^----------------------------------------------------------------------------------------------- [docker run]