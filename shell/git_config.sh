#!/usr/bin/env bash

# ---------------------------
# Git Configuration
# ---------------------------

# Git identity for multi-client repos
git config --global user.name "Sabry"
git config --global user.email "vendorah2@gmail.com"

# Faster Git performance in Codespaces
git config --global fetch.parallel 20
git config --global gc.auto 0

# Additional helpful Git settings
git config --global pull.rebase false
git config --global init.defaultBranch main
git config --global core.editor "nano"

echo "✅ Git configuration applied"
