FROM buildkite/puppeteer:latest

RUN apt update && apt install -y git
RUN npm install git+https://git@github.com/kaleocheng/swagger2markdown.git seq-cli
ENV  PATH="${PATH}:/node_modules/.bin"
