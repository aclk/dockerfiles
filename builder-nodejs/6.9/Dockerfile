FROM node:6.9

# Install strong-build to prepare the archive
RUN npm install -g strong-build \
    && npm cache clean

ENV node_version 6.9

COPY _files/Dockerfile-runner-${node_version}.tpl /app/Dockerfile
COPY _files/setup-runner.sh /app/

#
# Prepare BUILD operations
#
# 1. separate package.json from the rest to keep the cache
# 2. install packages, including native extensions (keep cache)
# 3. copy the remaining of the code
# 4. run the build/pack operation and prepare the docker context
#
ONBUILD COPY package.json /app/src/
ONBUILD WORKDIR /app/src
ONBUILD RUN npm install --scripts --production \
    && npm cache clean
ONBUILD COPY . /app/src
ONBUILD RUN sl-build --npm \
    && cd /app \
    && mv *tgz artifact.tgz \
    && tar czf builder-context.tar.gz Dockerfile setup-runner.sh artifact.tgz

ENTRYPOINT ["cat", "/app/builder-context.tar.gz"]
