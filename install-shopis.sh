#!/bin/bash

BASH_SCRIPT="$(dirname "$0")/shopis_bash.sh"
ZSH_SCRIPT="$(dirname "$0")/shopis_zsh.sh"
BASH_PROFILE="$HOME/.bash_profile"
ZSHRC="$HOME/.zshrc"

function already_installed() {
  local profile_file="$1"
  grep -q '^shopis()' "$profile_file"
}

function remove_old_functions() {
  local profile_file="$1"
  # Remove shopis() and shopipull() function definitions
  sed -i.bak '/^shopis()/,/^}/d' "$profile_file"
  sed -i.bak '/^shopipull()/,/^}/d' "$profile_file"
  # Remove backup file
  rm -f "$profile_file.bak"
}

function prompt_reinstall() {
  local profile_file="$1"
  read -p "shopis() is already installed in $profile_file. Do you want to reinstall (replace the old version)? [y/N]: " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    remove_old_functions "$profile_file"
    return 0
  else
    echo "Skipping $profile_file."
    return 1
  fi
}

echo "Which shell profile would you like to append the shopis functions to?"
select shell_choice in "Bash" "Zsh" "Both" "Quit"; do
  case $shell_choice in
    Bash )
      if [ ! -f "$BASH_PROFILE" ]; then
        touch "$BASH_PROFILE"
      fi
      if already_installed "$BASH_PROFILE"; then
        if prompt_reinstall "$BASH_PROFILE"; then
          cat "$BASH_SCRIPT" >> "$BASH_PROFILE"
          echo "shopis_bash.sh contents have been added to ~/.bash_profile."
        fi
      else
        cat "$BASH_SCRIPT" >> "$BASH_PROFILE"
        echo "shopis_bash.sh contents have been added to ~/.bash_profile."
      fi
      break
      ;;
    Zsh )
      if [ ! -f "$ZSHRC" ]; then
        touch "$ZSHRC"
      fi
      if already_installed "$ZSHRC"; then
        if prompt_reinstall "$ZSHRC"; then
          cat "$ZSH_SCRIPT" >> "$ZSHRC"
          echo "shopis_zsh.sh contents have been added to ~/.zshrc."
        fi
      else
        cat "$ZSH_SCRIPT" >> "$ZSHRC"
        echo "shopis_zsh.sh contents have been added to ~/.zshrc."
      fi
      break
      ;;
    Both )
      if [ ! -f "$BASH_PROFILE" ]; then
        touch "$BASH_PROFILE"
      fi
      if already_installed "$BASH_PROFILE"; then
        if prompt_reinstall "$BASH_PROFILE"; then
          cat "$BASH_SCRIPT" >> "$BASH_PROFILE"
          echo "shopis_bash.sh contents have been added to ~/.bash_profile."
        fi
      else
        cat "$BASH_SCRIPT" >> "$BASH_PROFILE"
        echo "shopis_bash.sh contents have been added to ~/.bash_profile."
      fi
      if [ ! -f "$ZSHRC" ]; then
        touch "$ZSHRC"
      fi
      if already_installed "$ZSHRC"; then
        if prompt_reinstall "$ZSHRC"; then
          cat "$ZSH_SCRIPT" >> "$ZSHRC"
          echo "shopis_zsh.sh contents have been added to ~/.zshrc."
        fi
      else
        cat "$ZSH_SCRIPT" >> "$ZSHRC"
        echo "shopis_zsh.sh contents have been added to ~/.zshrc."
      fi
      break
      ;;
    Quit )
      echo "❌ Installation canceled."
      exit 1
      ;;
    * )
      echo "Please choose 1, 2, 3, or 4."
      ;;
  esac
done

echo "Restart your terminal or run 'source ~/.bash_profile' or 'source ~/.zshrc' to apply changes."
