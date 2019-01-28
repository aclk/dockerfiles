FROM buildkite/puppeteer:latest

RUN apt update && apt install -y git graphviz
RUN npm install swg2md seq-cli
COPY build.sh /build.sh
COPY puppeteer.json /puppeteer.json
COPY template.mustache /template.mustache
COPY swagger2markdown.js /swagger2markdown.js
ENV  PATH="${PATH}:/node_modules/.bin"
WORKDIR /app
CMD bash /build.sh
