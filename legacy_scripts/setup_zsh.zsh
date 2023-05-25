#!/usr/bin/env zsh

echo "\n<<< Starting ZSH Setup >>>\n"

# The installation of ZSH through Homebrew is already included in the Brewfile.

# Add Homebrew-installed ZSH to /etc/shells
if grep -Fxq "$(brew --prefix)/bin/zsh" "/etc/shells"; then
    echo "Homebrew-installed ZSH already exists in /etc/shells"
else
    echo "Enter superuser (sudo) password to edit /etc/shells"
    echo "$(brew --prefix)/bin/zsh" | sudo tee -a "/etc/shells" >/dev/null
fi

# Make Homebrew-installed ZSH the default login shell for this user
if [ "$SHELL" = "$(brew --prefix)/bin/zsh" ]; then
    echo "Homebrew-installed ZSH is already set as the default login shell for $USER"
else
    echo "Enter user password to change login shell"
    chsh -s "$(brew --prefix)/bin/zsh"
fi
