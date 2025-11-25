#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dotfiles"

append_once() {
  LINE="$1"
  FILE="$2"
  grep -qxF "$LINE" "$FILE" || echo "$LINE" >> "$FILE"
}

echo "🚀 Installing dotfiles configuration..."

# Load Odoo aliases
append_once "" "$HOME/.bashrc"
append_once "# Load custom Odoo aliases" "$HOME/.bashrc"
append_once "if [ -f \"$DOTFILES_DIR/shell/odoo_aliases.sh\" ]; then source \"$DOTFILES_DIR/shell/odoo_aliases.sh\"; fi" "$HOME/.bashrc"

# Load Git config
append_once "# Load Git custom settings" "$HOME/.bashrc"
append_once "if [ -f \"$DOTFILES_DIR/shell/git_config.sh\" ]; then source \"$DOTFILES_DIR/shell/git_config.sh\"; fi" "$HOME/.bashrc"

echo "✅ Dotfiles configuration installed successfully!"
echo "💡 Run 'source ~/.bashrc' to apply changes immediately"
