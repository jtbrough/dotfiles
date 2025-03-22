#!/bin/bash
echo "################################################################################"
echo "########## bash cleanup"

# Only run if shell is zsh
if [ "$(getent passwd $LOGNAME | cut -d: -f7)" = "$(which zsh)" ]; then

    # List of files to remove
    bash_files=(
        "$HOME/.bash_history"
        "$HOME/.bash_logout"
        "$HOME/.bashrc"
        "$HOME/.bash_profile"
        "$HOME/.profile"
    )

    # Remove each file if it exists
    for file in "${bash_files[@]}"; do
        if [ -f "$file" ]; then
            rm "$file"
            echo "########## Removed: $file"
        fi
    done
    echo "################################################################################"
fi