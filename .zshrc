PROMPT="%B%n%b: %F{cyan}%(5~|%-1~/.../%3~|%4~)%f %(!.#.$) "
export EDITOR=vim
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export PATH=$HOME/.local/bin:$PATH
export LS_COLORS="tw=01;34:ow=01;34" # change the colors for o+w directories, so ugly and eye paining
export LC_COLLATE="C" # To make ls show dotfiles separately

# Lines configured by zsh-newuser-install (these lines extremely slow down my zsh startup)
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=999999999
setopt autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

# Would have also been by zsh-newuser-install but i was too dumb to notice the option there
autoload -Uz compinit
compinit

# Cleaning up some files from home directory (i love you archwiki https://wiki.archlinux.org/title/XDG_Base_Directory)
export RUSTUP_HOME=$HOME/.local/share/rustup
export CARGO_HOME=$HOME/.local/share/cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup.py"
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export SSB_HOME="$XDG_DATA_HOME"/zoom
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
rm -rf ~/.zcompdump
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

# Ultra completion colors (but why are directories red can you fix that future safwan)
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")'

# Don't repeat the same command when pressing up arrow, also makes duplicates gone in the history file but whatever
setopt HIST_IGNORE_ALL_DUPS

# Ok i return back to this mode the last extreme auto expand sucks
zstyle ':completion:*' completer _expand_alias _complete _ignored

# thefuck alias(????) setup
eval $(thefuck --alias)

# Enable syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# To have paths colored instead of underlined <- copy pasted this as well
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'


# Aliases and functions
alias ls="ls --color=auto"
alias ll="ls -FlAhG --group-directories-first --color=always --time-style='+%d %b %Y %I:%M %p'"
alias lls="ls -Flh --group-directories-first --color=always"
alias lld="ll | grep '^d'"
alias llf="ll | grep -v '^d\|^l'"                      # well shit this command can't display links to files
alias grep="grep --color=auto"
alias c="clear"
alias hddon="sudo mount /dev/sda2 /mnt/hdd"
alias hddoff="sudo hdparm -Y /dev/sda"
alias lssize="du -sh *(D) 2> /dev/null | sort -h"
alias storage="df -h /"
alias open="xdg-open 2> /dev/null"
alias feh="feh -. -Z --geometry 1392x783 --image-bg black"
alias wifioff="iwctl station wlan0 disconnect"
alias wifion="iwctl station wlan0 connect 'safwan 2.4GHz'"
alias wifiinfo="iwctl station wlan0 show"; alias wifistatus=wifiinfo
alias wifiscan="iwctl station wlan0 scan; iwctl station wlan0 get-networks"
alias routine="feh ~/Documents/class\ 7/class_routine.png &"
alias bat="bat --theme=base16"
alias less="less -R"
alias lmao="echo Fuck you!"

# done: pls make a function here that sets the opacity of alacritty once you have the knowledge to do it
# update: i now have the knowledge to do it
opacity() {
	sed -i "s/background_opacity .*/background_opacity $1/" ~/.config/kitty/kitty.conf
}

ccll() {
	cd $1 && c; ll
}

firefox() {
	/usr/bin/firefox file://$(realpath $1)
}

fan() {
	echo "CPU info:"
	sensors | grep --color=never "fan1\|fan2"
	printf "Temp: "
	sensors | tail | awk '{print $4}' | grep --color=never "C" | cut -d "+" -f 2 # this is is fucking ugly but it works so i don't care
	echo "\nGPU info:"
	echo Fan:  $(nvidia-smi --query-gpu=fan.speed --format=csv,noheader)	
	echo Temp: $(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)°C
}

volume() {
	pactl set-sink-volume @DEFAULT_SINK@ ${1}%
}

block() {
	cat <<-Fuck | sudo tee -a /etc/hosts
		127.0.0.1 www.discord.com
		127.0.0.1 cdn.discordapp.com
		127.0.0.1 www.youtube.com
		127.0.0.1 www.twitter.com
		127.0.0.1 twitter.com
		127.0.0.1 www.reddit.com
		127.0.0.1 www.instagram.com
Fuck
}

# done: make this more harder to excute, like add something randomly generated to type out
# lmao this is beautiful
unblock() {
	randomstring=$(openssl rand -base64 5)
	printf "Type $randomstring exactly the way it is: "
	read answer
	if [ "$answer" != $randomstring ]; then
		echo 'Fuck you!'
		return
	fi

	head -n 2 /etc/hosts | sudo tee /etc/hosts
}

# Ultra gcc shortcut function holy shit
gccc() {
	name=$(echo $1 | cut -d'.' -f1)
	[[ -n $2 ]] && otherargs=$(echo $@ | cut -d' ' -f2-)

	gcc $1 -o $name $otherargs
	
	returncode=$?
	unset name; unset otherargs

	return $returncode
}

# Extremely bad way of making git think that my-files is a proper repo
# limitations :-
# - Only works when at the root of my-files (which is ~/safwan_home/my-files)
# - Ok i kinda "hacked" that limitation
# - That find command with pipes is probably sort of slow
# - I am exhausted and finding the -empty option in the find command was a really close call
git() {
	if [[ "$PWD" =~ ^\/home\/safwan6363\/safwan_file\/my-files ]]; then
		cd ~/safwan_file/my-files
		folders=( $(find -type d -empty -not -path './.git/*' | cut -d'/' -f 2- | tr '\n' ' ') )

		for folder in $folders; do
			sudo mount --bind $HOME/$folder $(realpath $folder)
		done
		echo mounted

		/usr/bin/git $@

		cd - > /dev/null

		for folder in $folders; do
			sudo umount $folder
		done
		echo unmounted
	else
		/usr/bin/git $@
	fi
}

# Easy cloudflare warp toggle off and on
warp() {
	if ! systemctl status warp-svc > /dev/null; then
		sudo systemctl start warp-svc.service
		echo "Starting service"
		sleep 2
	fi

	if warp-cli status | grep Disconnected > /dev/null; then
		warp-cli connect
		echo "Turned on"
	else
		warp-cli disconnect
		echo "Turned off"
	fi
}

commit() {
	git commit -am $1 && git push
}


# KEYBINDING SETUP copied from arch wiki
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"
# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -s "${key[Insert]}"     ''
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" emacs-forward-word
[[ "$TERM" != "xterm" ]] && bindkey '^H' backward-kill-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
# Keybinding setup end

# Set a good colorscheme in tty (copy pasted from http://web.archive.org/web/20150225020624/http://phraktured.net:80/linux-console-colors.html)
if [ "$TERM" = "linux" ]; then
    #Black / Light black
    # echo -en "\e]P0222222"
    echo -en "\e]P8666666"
    #Red / Light red
    echo -en "\e]P1cc4747"
    echo -en "\e]P9bf5858"
    #Green / Light green
    echo -en "\e]P2a0cf5d"
    echo -en "\e]PAb8d68c"
    #Yellow / Light yellow
    echo -en "\e]P3e0a524"
    echo -en "\e]PBedB85c"
    #Blue / Light blue
    echo -en "\e]P44194d9"
    echo -en "\e]PC60aae6"
    #Purple / Light purple
    echo -en "\e]P5cc2f6e"
    echo -en "\e]PDdb588c"
    #Cyan / Light cyan
    echo -en "\e]P66d878d"
    echo -en "\e]PE42717b"
    #White / Light white...?
    echo -en "\e]P7c4c4c4"
    echo -en "\e]PFfefefe"

     #this is an attempt at working utf8 line drawing chars in the linux-console
#    export TERM=linux+utf8
fi

