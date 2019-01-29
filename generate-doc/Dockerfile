FROM buildkite/puppeteer:latest

RUN apt update && apt install -y git graphviz
RUN npm install swg2md seq-cli markdown-toc tree-node-cli
COPY build.sh /build.sh
COPY build-images.sh /build-images.sh
COPY puppeteer.json /puppeteer.json
COPY template.mustache /template.mustache
COPY render-doc.js /render-doc.js
ENV  PATH="${PATH}:/node_modules/.bin"
WORKDIR /app
CMD bash /build.sh
