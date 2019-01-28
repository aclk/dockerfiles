#!/usr/bin/env bash
set -e

diagrams="diagrams"
pages="pages"
images="$pages/images"
imgext="svg"

mkdir -p "$pages"
mkdir -p "$images"

function gendot() {
    for f in $(ls "$diagrams/$dir"/*.dot | xargs -n 1 basename); do
        filename="${f%.*}"
        dot -T$imgext "/app/$diagrams/$dir/$f" -o "/app/$images/$dir/$filename.$imgext"
    done
}

function genseq() {
    for f in $(ls "$diagrams/$dir"/*.seq | xargs -n 1 basename); do
        filename="${f%.*}"
        seq-cli -p "/puppeteer.json" -i "/app/$diagrams/$dir/$f" -o "/app/$images/$dir/$filename.$imgext"
    done
}

for dir in $(ls "$diagrams"); do
    mkdir -p "$images/$dir"
    case "$dir" in
        dot) gendot ;;
        seq) genseq ;;
        *) echo "others" ;;
    esac
done

for f in $(ls *.md); do
   node /swagger2markdown.js "$f" > "$pages/$f"
done
