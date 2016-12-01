FROM node:4.6

# Install Strong-PM and build tools
RUN useradd -ms /bin/bash strong-pm \
    && chown -R strong-pm:strong-pm /usr/local \
    && su strong-pm -c "npm install -g strong-pm strong-deploy && npm cache clean"

# Expose strong-pm port
EXPOSE 8701 3001

# Set up some semblance of an environment
WORKDIR /home/strong-pm
ENV HOME=/home/strong-pm

USER strong-pm

# Prepare BUILD operations
COPY setup-runner.sh /home/strong-pm
COPY artifact.tgz /home/strong-pm
RUN bash setup-runner.sh

ENTRYPOINT ["/usr/local/bin/sl-pm", "--base", ".", "--listen", "8701", "--skip-default-install"]

