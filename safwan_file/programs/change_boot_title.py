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
    "Did you boot having something interesting (and socially deteriorating) to do unlike using iPad or school?",
    "You pathetic loser.",
    "What have you been up to lately? You don't use your computer often as much. Have you lost your mind yet? Have you slowly forgotten everything which made you \'unique\' and \'smart\'?"
]

with open("/etc/issue", "r+") as issue:
    lastline = issue.readlines()[-1]
    issue.seek(0) # just to be safe idk really if this needed
    issue.truncate(0)
    issue.write(f"{random.choice(titles)}\n\nArch Linux \\r (\\l)\n\\d \\t\n\n")
