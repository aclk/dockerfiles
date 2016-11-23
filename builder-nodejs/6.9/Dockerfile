FROM node:6.9

# Install strong-build to prepare the archive
RUN npm install -g strong-build \
    && npm cache clear

ENV node_version 6.9

COPY _files/extract_artifact_name.py /usr/local/bin
COPY _files/Dockerfile-runner-${node_version}.tpl /usr/src/Dockerfile
COPY _files/setup-runner.sh /usr/src/

# Prepare BUILD operations
ONBUILD COPY package.json /usr/src/app/
ONBUILD WORKDIR /usr/src/app/
ONBUILD RUN npm install
ONBUILD COPY . /usr/src/app
ONBUILD RUN sl-build --bundle --install --pack --scripts \
    && cd /usr/src \
    && mv $(extract_artifact_name.py /usr/src/app/package.json) artifact.tgz \
    && tar czvf builder.tar.gz Dockerfile setup-runner.sh artifact.tgz

ENTRYPOINT ["cat", "/usr/src/builder.tar.gz"]
