import sys
import subprocess

shit = subprocess.run(["pacman", "-Ql", sys.argv[1]], capture_output=True)
if shit.stderr.decode("ascii"): 
    print(shit.stderr.decode("ascii"), end="")
    sys.exit()

output = shit.stdout.decode("ascii")[:-1].split('\n') # get rid of the trailing newline and split it to a string
output = list(map(lambda x: x.removeprefix(f'{sys.argv[1]} ') , output)) # remove the program name before each line
output = list(filter(lambda x: not x.endswith('/'), output)) # Remove directories

# wasted three hours writing all these shit lmao before deciding on a much shorter less painful way of getting the paths 
# # "\x1B[38;5;179"
# for i in range(len(output)):
#     line = output[i]
#     ls = subprocess.run(["ls", "-lF", "--color=always", line], capture_output=True).stdout.decode("ascii").strip()
#     # Get parts to color
#     dirpart = "/".join(ls.split(" ")[8].split('/')[:-1]) + "/"
#     filepart = " ".join(ls.split(" "))[8:].split('/')[-1]
#     
#     # The directory part will be coloured yellow
#     dirpart = "\x1B[0;33m" + dirpart + "\x1b[0m"
#     
#     # The file part will be coloured green if it is executable
#     permissions = ls.split(" ")[0]
#     # if "x" in permissions and not ls.endswith("gz"):
#     print(ls)
#     print(dirpart)
#     print(filepart)
#     # filepart = "\x1B[0;32m" + filepart + "\x1b[0m"

ls = subprocess.run(["ls", "-lF", "--color=always"] + output, capture_output=True).stdout.decode("ascii").strip())
print(ls)
