import sys
import subprocess

# TODO Somehow make this serach all the arch repository packages as well ( maybe even the AUR ???? 😮😮😮☹☹☹ ) USE THE FUCKING PKGFILE COMMAND FOR THE SAME TYPE OF COMMAND NOT FOUND AS UBUNTU OMGGGOOO] wiat ugh nvmn it cant serch the aur BUT FUCK IN GOIYUOSEIURUWSER
# TODO please make it so it doesnt fucking suggest the same command
# Test all the commands here with your newly made script after you've finished all those todos. https://youtu.be/bx3aJyWy7Pc

def similar_words(word):
    """
    return a set with spelling1 distance alternative spellings

    based on http://norvig.com/spell-correct.html
    """
    alphabet = 'abcdefghijklmnopqrstuvwxyz-_0123456789'
    s = [(word[:i], word[i:]) for i in range(len(word) + 1)]
    deletes = [a + b[1:] for a, b in s if b]
    transposes = [a + b[1] + b[0] + b[2:] for a, b in s if len(b) > 1]
    replaces = [a + c + b[1:] for a, b in s for c in alphabet if b]
    inserts = [a + c + b     for a, b in s for c in alphabet]
    return set(deletes + transposes + replaces + inserts)

def bash_command(cmd):
    sp = subprocess.Popen(['/bin/bash', '-c', cmd], stdout=subprocess.PIPE)
    return [s.decode('utf-8').strip() for s in sp.stdout.readlines()]

def main():
    word = sys.argv[1]
    command_list = bash_command('compgen -ck')
    result = list(set(similar_words(word)).intersection(set(command_list)))

    if len(result) > 0:
        wrong_command_str = "Dumbass did you mean:"
        indent = len(wrong_command_str)//2

        print("Dumbass did you mean:")
        for cmd in result:
            print(indent*" ",cmd)

if __name__ == '__main__':
    main()
