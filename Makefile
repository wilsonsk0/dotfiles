.PHONY=all

all:
	@git submodule init
	@git submodule update
	@echo "-- Building pyenv"
	@./.pyenv/src/configure
	@make -C .pyenv/src

install: all
	@echo "-- Installing lazygit"
	@go install github.com/jesseduffield/lazygit@latest
	@echo "-- Installing ripgrep"
	@cargo install --path ripgrep
	@echo "-- Installing fzf"
	@./.fzf/install --key-bindings --completion --no-update-rc --no-bash --no-zsh --no-fish > /dev/null
	@echo "-- Install zoxide"
	@cargo install --path zoxide
	@echo "-- Installing JetBrainsMono patched font"
	@cd nerd-fonts && ./install.sh JetBrainsMono > /dev/null
	@stow .

