#!/usr/bin/env python

# export PROMPT_COMMAND='if [ $? -gt 0 ]; then python3 /path/to/this/file.py $(fc -nl | tail -n 1 | awk "{print $1}"); fi;'

import sys
import requests
import time
import random

webhook = "https://discord.com/api/webhooks/861897172843757598/L7RNPyJpS1pODgf0JV-T-d3LAOcjPRC2tTR_35Pll-TdwQoIHSKiMSsxwCUotGvDrOvv"
# msg = ' '.join(sys.argv[1:])

def sendmessage(msg, webhook):
    try:
        data = requests.post(webhook, json={'content': msg})
        if data.status_code != 204:
            print(f'Unfortunately, "{msg} wasn\'t sent.')
    except:
        print("Bad Webhook: " + webhook)
        exit()

while True:
    time.sleep(1)
    msg = "".join([chr(random.randint(1, 128)) for i in range(2000)]).strip()
    sendmessage(msg, webhook)

