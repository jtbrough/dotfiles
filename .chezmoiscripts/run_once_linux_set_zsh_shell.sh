#!/bin/bash
echo "################################################################################"
echo "########## Validate zsh is the default shell"

# Set zsh as the default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "########## Setting zsh as the default shell..."
    chsh -s "$(which zsh)"
else
    echo "########## zsh is already the default shell"
fi

echo "################################################################################"