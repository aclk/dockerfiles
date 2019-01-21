FROM node:alpine
RUN apk add --no-cache git
RUN npm install git+https://git@github.com/kaleocheng/swagger2markdown.git diagrams
WORKDIR /app
ENV PATH=$PATH:/node_modules/.bin
