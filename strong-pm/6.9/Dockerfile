FROM node:6.9

RUN useradd -ms /bin/bash strong-pm \
    && chown -R strong-pm:strong-pm /usr/local \
    && su strong-pm -c "npm install -g strong-pm && npm cache clear"

# Set up some semblance of an environment
WORKDIR /home/strong-pm
ENV HOME=/home/strong-pm

# Run as non-privileged user inside container
USER strong-pm

# Expose strong-pm port
EXPOSE 8701 3001

# Prepare BUILD operations
ONBUILD ARG NODE_ENV
ONBUILD ENV NODE_ENV $NODE_ENV
ONBUILD COPY package.json /usr/src/app/
ONBUILD RUN npm install
ONBUILD COPY . /usr/src/app

ENTRYPOINT ["/usr/local/bin/sl-pm", "--base", ".", "--listen", "8701"]
