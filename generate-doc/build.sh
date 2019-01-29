#!/usr/bin/env bash
set -e

pages="pages"
app="app"
doc="docs"

source /build-images.sh

for f in "/$app/$doc/"*.md
do
   f=$(basename "$f")
   node /render-doc.js "/$app/$doc/$f" > "/$app/$doc/$pages/$f"
done
