source ~/.config/zsh/init.zsh
autoload -U compinit
zstyle ':completion:*' menu select

# bun completions
[ -s "/home/cross/.bun/_bun" ] && source "/home/cross/.bun/_bun"
setopt clobber

# pnpm
export PNPM_HOME="/home/cross/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
