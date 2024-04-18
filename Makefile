.PHONY=all

all:
	@git submodule init
	@git submodule update
	@./.pyenv/src/configure
	@make -C .pyenv/src

install: all
	@echo "-- Installing fzf"
	@./.fzf/install --key-bindings --completion --no-update-rc --no-bash --no-zsh --no-fish > /dev/null
	@echo "-- Install zoxide"
	@curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash > /dev/null
	@stow .

