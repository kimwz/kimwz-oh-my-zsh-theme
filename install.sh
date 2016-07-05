#!/usr/bin/env zsh

# Source ~/.zshrc because we need oh-my-zsh variables
source "$HOME/.zshrc"

# Red bold error
function error() {
  echo
  echo "$fg_bold[red]Error: $* $reset_color"
  echo
}

# Green bold message
function message() {
  echo
  echo "$fg_bold[green]Message: $* $reset_color"
  echo
}

# Files
REMOTE='https://raw.githubusercontent.com/kimwz/kimwz-oh-my-zsh-theme/master/kimwz.zsh-theme'
THEME="$ZSH_CUSTOM/themes/kimwz.zsh-theme"

# If themes folder isn't exist, then make it
[ -d $ZSH_CUSTOM/themes ] || mkdir $ZSH_CUSTOM/themes

# Download theme from repo
if $(command -v curl >/dev/null 2>&1); then
  # Using curl
  curl -o $THEME $REMOTE || { error "Filed!" ; return }
elif $(command -v wget >/dev/null 2>&1); then
  # Using wget
  wget -O $THEME $REMOTE || { error "Filed!" ; return }
else
  # Exit with error
  error "curl and wget are unavailable!"
  exit 1
fi

# Replace current theme to new theme.
sed -ie "s/ZSH_THEME=.*/ZSH_THEME='kimwz'/g" "$HOME/.zshrc" \
|| error "Cannot change theme in ~/.zshrc. Please, do it by yourself." \
&& message "Done! Please, reload your terminal."

exec zsh
