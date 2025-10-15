# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/andrel/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Autostart
fastfetch

# Prompt
PROMPT='%(?.%F{green}.%F{red})╭──%f %F{#c6a0f6}%n%F{#b7bdf8}@%m %(?.%F{green}.%F{red})─%F{#f0c6c6}  %2~%f
%(?.%F{green}.%F{red})╰─🠞 %f'

# Auto-suggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6e738d"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

# Add .local/bin to PATH
PATH=$HOME/.local/bin:$PATH

# Alias
alias ls='eza -lh'
alias tree='tree -C -L 1'
alias py=python
alias py3=python3
alias cat=bat
alias trash='gio trash'
alias dumpsterdive='gio trash --list'
alias garbageday='gio trash --empty'
alias recycle='gio trash --restore'
alias set-brightness='ddcutil -d 1 setvcp x10'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
