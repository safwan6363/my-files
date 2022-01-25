PROMPT="%B%n%b: %F{cyan}%(5~|%-1~/.../%3~|%4~)%f %(!.#.$) "
export EDITOR=vim
export XDG_CONFIG_HOME=$HOME/.config
export PATH=$HOME/.local/bin:$PATH

# Rust installation to .local/share instead of ~
export RUSTUP_HOME=$HOME/.local/share/rustup
export CARGO_HOME=$HOME/.local/share/cargo
source ~/.local/share/cargo/env 

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

# Would have also been by zsh-newuser-install but i was too dumb to notice the option there
autoload -Uz compinit
compinit

# Ultra completion colors (but why are directories red can you fix that future safwan)
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")'

# Don't repeat the same command when pressing up arrow, also makes duplicates gone in the history file but whatever
setopt HIST_IGNORE_ALL_DUPS

# Enable syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# To have paths colored instead of underlined <- copy pasted this as well
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'


# Aliases and functions
alias ls="ls --color=auto"
alias ll="ls -FlAh --group-directories-first --color=always"
alias lls="ls -Flh --group-directories-first --color=always"
alias lld="ll | grep '^d'"
alias llf="ll | grep -v '^d\|^l'"                      # well shit this command can't display non directory links
alias grep="grep --color=auto"
alias c="clear"
alias hddon="sudo mount /dev/sda2 /mnt/hdd"
alias hddoff="sudo hdparm -Y /dev/sda"
alias storage="du -sh * 2> /dev/null | sort -h"         # todo : make this alias work with dotfiles.
alias lssize="df -h | awk 'NR==1 || NR==4'"
alias open="xdg-open 2> /dev/null"
alias feh="feh -. -Z --geometry 1392x783 --image-bg black"
alias paclist='python3 ~/safwan_file/scripts/better_pacman_ql_output.py'
alias wlanoff="iwctl station wlan0 disconnect"
alias wlanon="iwctl station wlan0 connect 'safwan 2.4GHz'"
alias routine="feh ~/Documents/class\ 7/class_routine.png &"
alias bat="bat --theme=base16"
alias less="less -R"

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
		::1 www.discord.com
		::1 cdn.discordapp.com
		::1 www.youtube.com
		::1 www.twitter.com
		::1 twitter.com
		::1 www.reddit.com
Fuck
}

# TODO: make this more harder to excute, like add something randomly generated to type out
unblock() {
	head -n 2 /etc/hosts | sudo tee /etc/hosts
}

commit() {
	git commit -am $1 && git push
}

# Ultra gcc shortcut function holy shit
gccc() {
	name=$(echo $1 | cut -d'.' -f1)
	otherargs=$(echo $@ | cut -f2-)

	gcc $1 -o $name $otherargs
}

# To make ls show dotfiles separately
LC_COLLATE="C"


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
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word
bindkey '^H' backward-kill-word

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

# The following is copied from https://github.com/simnalamburt/zsh-expand-all/blob/master/zsh-expand-all.zsh
# Auto expand aliases.
--expand-internal() {
  local disable_list=("${(@s|,|)ZSH_EXPAND_ALL_DISABLE}")
  [[ ${disable_list[(ie)alias]} -gt ${#disable_list} ]] && zle _expand_alias
  [[ ${disable_list[(ie)word]}  -gt ${#disable_list} ]] && zle expand-word
}

expand-all() {
  --expand-internal
  zle self-insert
}
zle -N expand-all

expand-all-enter() {
  --expand-internal
  zle accept-line
}
zle -N expand-all-enter
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(expand-all-enter)

# space expands all aliases, including global
bindkey -M emacs " " expand-all
bindkey -M emacs "^M" expand-all-enter

# control-space to make a normal space
bindkey -M emacs "^ " magic-space

# normal space during searches
bindkey -M isearch " " magic-space
# Auto alias expand setup end
