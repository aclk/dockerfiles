FROM node:6.9

RUN npm config set registry=https://registry.npm.taobao.org -g

# Install strong-build to prepare the archive
RUN npm install -g strong-build \
    && npm cache clean

ENV node_version 6.9

COPY _files/extract_artifact_name.py /usr/local/bin
COPY _files/Dockerfile-runner-${node_version}.tpl /usr/src/Dockerfile
COPY _files/setup-runner.sh /usr/src/

# Prepare BUILD operations
ONBUILD COPY package.json /usr/src/app/
ONBUILD WORKDIR /usr/src/app/
ONBUILD RUN npm install --production  && npm cache clean # Skip devDepencencies and clean up
ONBUILD COPY . /usr/src/app
ONBUILD RUN sl-build --bundle --install --pack --scripts \
    && cd /usr/src \
    && mv $(extract_artifact_name.py /usr/src/app/package.json) artifact.tgz \
    && tar czvf builder.tar.gz Dockerfile setup-runner.sh artifact.tgz

ENTRYPOINT ["cat", "/usr/src/builder.tar.gz"]
