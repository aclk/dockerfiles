# Builder

Collection of builder scripts

## Builder NodeJS

### Prepare builder-nodejs

The builder-nodejs container contains ONBUILD statements, allowing to build dedicated build containers images for any nodejs app.

- **Node JS 4.6 builder**

```
cd builder-nodejs/4.6
docker build -t builder-nodejs:4.6 .
```

- **Node JS 6.9 builder**

```
cd builder-nodejs/6.9
docker build -t builder-nodejs:6.9 .
```

### Integration with code

Need to add `Dockerfile` to each repo - it depends which node version is expected

- For Node JS 4.6

```
FROM builder-nodejs:4.6
```

- For Node JS 6.9

```
FROM builder-nodejs:6.9
```

### Preparing container images

Once the `Dockerfile` has been created in each of the repository, you can run the following command to:
- create the builder
- run the builder
- create the runner from the builder

```
docker build -t builder-gateway . && ( docker run --rm builder-gateway | docker build -t gateway - )
```

# TODO

- Better docker container image tagging approach
- Add build version (based on the git commit?) as tag and/or in the image