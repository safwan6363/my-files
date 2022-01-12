PROMPT="%B%n%b: %F{cyan}%(5~|%-1~/…/%3~|%4~)%f %(!.#.$) "
export EDITOR=vim
export XDG_CONFIG_HOME=$HOME/.config
export RUSTUP_HOME=$HOME/.local/share/rustup
export CARGO_HOME=$HOME/.local/share/cargo

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

# Auto expand alias when you press tab, doesn't even work sometimes
zstyle ':completion:*' completer _expand_alias _complete _ignored

# Don't repeat the same command when pressing up arrow, also makes duplicates gone in the history file but whatever
setopt HIST_IGNORE_ALL_DUPS

# Enable syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# To have paths colored instead of underlined <- copy pasted this as well
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'

# Aliases and functions
alias ls="ls --color=always"
alias ll="ls -FlAh --group-directories-first"
alias lls="ls -Flh --group-directories-first"
alias lld="ll | grep '^d'"
alias llf="ll | grep -v '^d\|^l'"                      # well shit this command can't display non directory links
alias cll="c; ll"
alias grep="grep --color=auto"
alias c="clear"
alias volume="pactl set-sink-volume @DEFAULT_SINK@"
alias home_old="sudo mount /dev/sda3 /mnt/home_old"
alias hddoff="sudo hdparm -Y /dev/sda"
alias hddon=home_old
alias duh="du -sh * 2> /dev/null | sort -h"         # todo : make this alias work with dotfiles.
alias dfh="df -h | awk 'NR==1 || NR==4'"
alias open="xdg-open"
alias feh="feh -. -Z --geometry 1392x783 --image-bg black"
alias paclist='python3 ~/safwan_file/scripts/better_pacman_ql_output.py'

# TODOdone: pls make a function here that sets the opacity of alacritty once you have the knowledge to do it
# update: i now have the knowledge to do it
opacity() {
	sed -i "s/opacity: .*/opacity: $1/" ~/.config/alacritty/alacritty.yml
}

ccll() {
	cd $1 && c; ll
}

# firefox () {

# To make ls show dotfiles first
LC_COLLATE="C"

# KEYBINDING SETUP copied from arch wiki
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
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
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
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
