export ZSH=~/.zsh

# Load all of the config files in ~/oh-my-zsh that end in .zsh
for config_file ($ZSH/*.zsh) source $config_file

# Load and run compinit
autoload -U compinit
compinit -i

if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
