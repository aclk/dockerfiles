#!/usr/bin/env python
###############
# Output the expected file name from the npm pack command
# 
# Based on the package.json file
#
# Format: <package-name>-<package-version>.tgz
###############

import sys
import json

try:
    file = sys.argv[1]
except:
    sys.stderr.write('Missing file name')
    sys.exit(1)

if not os.path.exist(file):
    sys.stderr.write('Missing file: %s' % file)
    sys.exit(1)

with open(file) as f:
    data = json.load(f)

print '%s-%s.tgz' % (data.get('name'), data.get('version'))
