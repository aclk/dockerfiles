#!/bin/bash
####################
# Automate the build process
#
# Assumes:
#  - docker installed
#  - the app code available
#  - the app code coming from git (get commit #)
####################

echo "#######################################################"
echo " Docker builder for NodeJs Apps - powered by Strong-PM"
echo "#######################################################"
echo
echo "Notes:"
echo "  - Docker is expected to be installed, running and "
echo "    runnable by the current user"
echo "  - The APP code base is available, and updated to the"
echo "    version expected to be packaged (git is expected)"
echo

# Get the version
if [ -z "$1" ]; then
    echo -n "Which version of Node.js? (4.6/6.9) [default: 6.9] "
    read VERSION
else
    VERSION="$1"
fi

if [ -z "$VERSION" ]; then
    VERSION="6.9"
fi

# Get PATH
if [ -z "$2" ]; then
    echo -n "Full path of the app package.json: "
    read PKG_PATH
else 
    PKG_PATH="$2"
fi

if [ ! -e "$PKG_PATH" ]; then
    echo "Package file is missing. Aborting."
    exit 1
fi

# Get NPM registry
if [ -z "$3" ]; then
    echo -n "Which NPM registry: (china/default) "
    read REGISTRY
else 
    REGISTRY="$3"
fi


# Do the build of the builder source
cd ${VERSION}
echo "##"
echo "## Preparing the builder"
echo "##"
docker build -t builder-nodejs:${VERSION} .

# Get the current build of the app
cd $(dirname $PKG_PATH)
echo "##"
echo "## Preparing the builder"
echo "##"
COMMIT=$(git log --format="%h" -n 1)

# Build the builder for the app + build the runner
echo "##"
echo "## Preparing the Dockerfile for the App"
echo "##"
echo "FROM builder-nodejs:$VERSION" > Dockerfile

echo "##"
echo "## Building the app builder container"
echo "##"
# APP_NAME=$(head package.json | grep name | cut -d'"' -f4)
if [ -z "$APP_NAME" ]; then
    APP_NAME=`basename $(dirname $PKG_PATH)`
fi
if [ "$REGISTRY" == 'default' ]; then
    docker build -t builder-${APP_NAME} .
elif [ "$REGISTRY" == 'china' ]; then 
    docker build -t builder-${APP_NAME} --build-arg REGISTRY=https://registry.npm.taobao.org . 
fi

echo "##"
echo "## Building the app container"
echo "##"
docker run --rm builder-${APP_NAME} | docker build -t ${APP_NAME}:${COMMIT} -

echo "##"
echo "## Tagging the container"
echo "##"
docker tag ${APP_NAME}:${COMMIT} ${APP_NAME}:latest
