#!/bin/bash
echo "################################################################################"
echo "########## Validate homebrew is installed..."

# Check if Homebrew is already installed
if ! command -v brew >/dev/null 2>&1; then
    echo "########## Homebrew is not installed, installing now..."

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Verify installation
    brew doctor
else
    echo "########## Homebrew is already installed"
fi

echo "################################################################################"
