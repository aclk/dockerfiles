FROM buildkite/puppeteer:latest

RUN apt update && apt install -y git graphviz
RUN npm install git+https://git@github.com/kaleocheng/swagger2markdown.git seq-cli
COPY puppeteer.json /puppeteer.json
ENV  PATH="${PATH}:/node_modules/.bin"
