FROM node:6.9

# Install strong-build to prepare the archive
RUN npm install -g strong-build \
    && npm cache clear

# Prepare BUILD operations
ONBUILD COPY package.json /usr/src/app/
ONBUILD WORKDIR /usr/src/app/
ONBUILD RUN npm install
ONBUILD COPY . /usr/src/app
ONBUILD RUN sl-build --bundle --install --pack --scripts \
    && cp Dockerfile.builder.tpl /usr/src \
    && cp setup-runner.sh /usr/src \
    && cd /usr/src \
    && mv api-gateway-0.7.1.tar.gz artifact.tar.gz \
    && tar czvf builder.tar.gz Dockerfile setup-runner.sh artifact.tar.gz

ENTRYPOINT ["cat", "/usr/src/builder.tar.gz"]
