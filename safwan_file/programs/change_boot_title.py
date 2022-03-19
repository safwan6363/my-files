from subprocess import run
import random

titles = [
    "ok.",
    "I am so hagu boy tired of everything",
    "What am I my hagu?????????",
    run("fortune", capture_output=True).stdout.decode(), 
    "Did you do __that__ before turning the pc on?",
    "i have hagu turned on!!!!!!!!!!!!!!!!!!!",
    "Bet you're still lonely, got no one to talk to",
    "Did you boot having something interesting (and socially deteriorating) to do unlike using iPad or school?"
]

with open("/etc/issue", "r+") as issue:
    lastline = issue.readlines()[-1]
    issue.seek(0) # just to be safe idk really if this needed
    issue.truncate(0)
    issue.write(f"{random.choice(titles)}\n\nArch Linux \\r (\\l)\n\\d \\t\n\n")
