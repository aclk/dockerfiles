#!/usr/bin/env node

const swg2md = require('swg2md')
const fs = require('fs')
const toc = require('markdown-toc')

if (process.argv.length <= 2) {
    console.log('Need a file name')
    process.exit(1)
}

const filename = process.argv[2]


function readcontents(path) {
    if (fs.existsSync(path)) {
        return fs.readFileSync(path, 'utf8')
    }
    console.log(`${path} not found`)
}

function replace(origin, marker, contents) {
    const re = new RegExp(marker, 'g')
    return origin.replace(re, contents)
}

async function main() {
    let doc, contents, marker, output = ''
    doc = readcontents(filename)

    contents = await swg2md.render('/template.mustache', 'swagger.yaml')
    marker = '<!--function detailed design-->'
    output = replace(doc, marker, contents)

    contents = toc(output).content
    marker = '<!--toc-->'
    output = replace(output, marker, contents)

    console.log(output)
}

main()
