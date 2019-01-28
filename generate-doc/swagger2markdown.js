#!/usr/bin/env node

const swg2md = require('swg2md')
const fs = require('fs')
const toc = require('markdown-toc')

if (process.argv.length <= 2) {
    console.log('Need a file name')
    process.exit(1)
}

const filename = process.argv[2]


async function main() {
    const doc = fs.readFileSync(filename, 'utf8')
    const templateOutput = await swg2md.render('/template.mustache', 'swagger.yaml')
    const output = doc.replace(/<!--function detailed design-->/g, templateOutput)
    console.log(`${toc(output).content}\n${output}`)
}

main()
