# Setup fzf
# ---------
if [[ ! "$PATH" == */home/sam/.dotfiles/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/sam/.dotfiles/.fzf/bin"
fi

eval "$(fzf --bash)"
