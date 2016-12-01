FROM node:6.9

# Install strong-build to prepare the archive
RUN npm install -g strong-build \
    && npm cache clean

COPY Dockerfile-runner.tpl /app/Dockerfile
COPY setup-runner.sh /app/

#
# Prepare BUILD operations
#
# 1. separate package.json from the rest to keep the cache
# 2. allow build args to override the npm registry
# 3. install packages, including native extensions (keep cache)
# 4. copy the remaining of the code
# 5. run the build/pack operation and prepare the docker context
#
ONBUILD COPY package.json /app/src/
ONBUILD WORKDIR /app/src
ONBUILD ARG REGISTRY
ONBUILD ENV npm_config_registry ${REGISTRY} 
ONBUILD RUN npm install --scripts --production \
    && npm cache clean
ONBUILD COPY . /app/src
ONBUILD RUN sl-build --build --pack \
    && cd /app \
    && mv *tgz artifact.tgz \
    && tar czf runner-context.tar.gz Dockerfile setup-runner.sh artifact.tgz

ENTRYPOINT ["cat", "/app/runner-context.tar.gz"]
