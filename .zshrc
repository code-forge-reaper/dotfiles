source ~/.config/zsh/init.zsh
autoload -U compinit
zstyle ':completion:*' menu select

# bun completions
[ -s "/home/cross/.bun/_bun" ] && source "/home/cross/.bun/_bun"
setopt clobber
