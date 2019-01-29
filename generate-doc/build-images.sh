#!/usr/bin/env bash
set -e
shopt -s nullglob

diagrams="diagrams"
images="$pages/images"
imgext="svg"

mkdir -p "$pages"
mkdir -p "$images"


function gendot() {
    for f in  "/$app/$doc/$diagrams/$dir"/*.dot
    do
        f=$(basename "$f")
        filename="${f%.*}"
        dot -T$imgext "/$app/$doc/$diagrams/$dir/$f" -o "/$app/$doc/$images/$dir/$filename.$imgext"
    done
}

function genseq() {
    for f in "/$app/$doc/$diagrams/$dir"/*.seq
    do
        f=$(basename "$f")
        filename="${f%.*}"
        seq-cli -p "/puppeteer.json" -i "/$app/$doc/$diagrams/$dir/$f" -o "/$app/$doc/$images/$dir/$filename.$imgext"
    done
}

for dir in "/$app/$doc/$diagrams"/*
do
    dir=$(basename "$dir")
    mkdir -p "/$app/$doc/$images/$dir"
    case "$dir" in
        dot) gendot ;;
        seq) genseq ;;
        *) echo "others" ;;
    esac
done
