# dotfiles

## Platforms
[![Linux](https://img.shields.io/badge/Linux-Ready-orange?logo=linux&logoColor=white)](https://www.chezmoi.io/install)
[![macOS](https://img.shields.io/badge/macOS-Ready-green?logo=apple&logoColor=white)](https://www.chezmoi.io/install)
[![Windows](https://img.shields.io/badge/Windows-Soon-blue?logo=windows&logoColor=white)](https://www.chezmoi.io/install)

## New device setup
https://www.chezmoi.io/install

Linux 🐧 / macOS 🍎
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/jtbrough/dotfiles/main/dot_config/chezmoi/bootstrap.sh)"
```

Windows 🪟
```
iex "&{$(irm '[https://get.chezmoi.io/ps1](https://raw.githubusercontent.com/jtbrough/dotfiles/main/dot_config/chezmoi/bootstrap.ps1')}"
```

```
chezmoi init jtbrough
```

## Pull updates from github and apply them
https://www.chezmoi.io/user-guide/daily-operations
```
chezmoi update
```

## Make local changes and commit/push them to github (manual)
```
chezmoi edit $FILENAME
chezmoi cd ~
git status
git add $FILENAME
git commit -m "some message"
git push
```

## Automatically commit and push changes to github
~/.config/chezmoi/chezmoi.toml
```
[git]
    autoCommit = true
    autoPush = true
```
