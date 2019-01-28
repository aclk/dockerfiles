#!/usr/bin/env bash
set -e

pages="pages"

source /build-images.sh

for f in *.md
do
   node /render-doc.js "$f" > "$pages/$f"
done
