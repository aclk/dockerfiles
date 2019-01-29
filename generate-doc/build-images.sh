#!/usr/bin/env bash
set -e
shopt -s nullglob

diagrams="diagrams"
images="$pages/images"
imgext="svg"

mkdir -p "$pages"
mkdir -p "$images"

function gendot() {
    for f in  "$diagrams/$dir"/*.dot
    do
        f=$(basename "$f")
        filename="${f%.*}"
        dot -T$imgext "/app/$diagrams/$dir/$f" -o "/app/$images/$dir/$filename.$imgext"
    done
}

function genseq() {
    for f in "$diagrams/$dir"/*.seq
    do
        f=$(basename "$f")
        filename="${f%.*}"
        seq-cli -p "/puppeteer.json" -i "/app/$diagrams/$dir/$f" -o "/app/$images/$dir/$filename.$imgext"
    done
}


for dir in "$diagrams"/*
do
    dir=$(basename "$dir")
    mkdir -p "$images/$dir"
    case "$dir" in
        dot) gendot ;;
        seq) genseq ;;
        *) echo "others" ;;
    esac
done
