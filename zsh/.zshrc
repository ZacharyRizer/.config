export XDG_CONFIG_HOME="$HOME/.config"

HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTFILE=$HOME/.zsh_history

# Enable autocompletions
autoload -U compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zmodload -i zsh/complist
compinit

# Options
setopt auto_cd                   # cd by typing directory name if it's not a command
setopt auto_list                 # automatically list choices on ambiguous completion
setopt hist_ignore_all_dups      # remove older duplicate entries from history
setopt hist_reduce_blanks        # remove superfluous blanks from history items
setopt inc_append_history        # save history entries as soon as they are entered
setopt share_history             # share history between different instances
unsetopt correct_all             # autocorrect commands
unsetopt BEEP                    # no beep sounds
bindkey -e                       # emacs bindings

# basic exports
export CLICOLOR=1
export EDITOR="nvim"
export LESS="iMRS"
export VISUAL="$EDITOR"
export GPG_TTY=$(tty)

# Aliases
alias lg="lazygit"
alias ld="lazydocker"
alias rm="rm -i"

code() {
   open -a VsCode $1
}


# Put Homebrew's sbin in path
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# ------------------------ ==> FZF settings <== ------------------------------#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="
--bind 'ctrl-/:toggle-preview'
--bind 'ctrl-u:preview-half-page-up'
--bind 'ctrl-d:preview-half-page-down'
--height 70%
--info=inline
--layout=reverse
--multi
"

export FZF_CTRL_T_OPTS="
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 3> /dev/null | head -200'
"

export FZF_DEFAULT_COMMAND="fd --hidden -E '.git' -E '.venv' -E 'node_modules'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


# ------------------------- ==> python setup <== ----------------------------#
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PIPENV_VENV_IN_PROJECT=1
export PATH="$PYENV_ROOT/shims:$PATH"

# ------------------------ ==> nvm settings <== ------------------------------#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc


# ------------------------ ==> JAVA settings <== -----------------------------#
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

# ------------------------ ==> ghc settings <== ------------------------------#
[ -f "/Users/zrizer/.ghcup/env" ] && source "/Users/zrizer/.ghcup/env" # ghcup-env

# Set Starship as a prompt
eval "$(starship init zsh)"

# ZSH Packages
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
