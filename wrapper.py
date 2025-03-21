#!/usr/bin/python3

import base64
import os
import tempfile

print("Please send your JS code as Base64:")

code = ''
while (line := input()):
  code += line

code = base64.b64decode(code)

with tempfile.NamedTemporaryFile('wb') as f:
    f.write(code)
    f.flush()

    os.system(f'/srv/ladybird/bin/js {f.name}')
