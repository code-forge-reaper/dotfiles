# aliases
alias ls="eza -l"
alias la="ls -a"
alias pypy=pypy3
alias vgrind="valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes -s"

#alias ffrec="ffmpeg -f x11grab -i :0.0"
alias ffrec="ffmpeg -f x11grab -i :0.0 -f alsa -i default"

alias zshconf="$EDITOR ~/.zshrc; echo 'reloaded zsh'; exec zsh"
alias cat="bat"
# this can be chained, like: ../<other directory>
alias ..="cd .."

alias edit="$EDITOR"
# you can use this like: "$ e <filename>"
alias e="edit"

alias gcg="git config --global"
alias gas="git add .; git status --short"
alias ncm="ncmpcpp"
alias tree="tree -C"
alias ec="emacsclient -c"
alias el="emacsclient"
