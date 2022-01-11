#!/usr/bin/env python

# export PROMPT_COMMAND='if [ $? -gt 0 ]; then python3 /path/to/this/file.py $(fc -nl | tail -n 1 | awk "{print $1}"); fi;'

import sys
import requests

webhook = "https://discord.com/api/webhooks/892626694542856243/VTjOh0902Y0ObHV2yKvDNSBZh6dvtVbT8u-nQIuHUxyh6qqSfzn9SZD2jwea73CxdUDP"
msg = ' '.join(sys.argv[1:])

try:
    data = requests.post(webhook, json={'content': msg})
    if data.status_code != 204:
        print(f'Unfortunately, "{msg} wasn\'t sent.')
except:
    print("Bad Webhook :" + webhook)
    exit()