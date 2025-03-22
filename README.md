# dotfiles

## New device setup
https://www.chezmoi.io/install

linux / macos
```
sh -c "$(curl -fsLS get.chezmoi.io)"
```

windows
```
iex "&{$(irm 'https://get.chezmoi.io/ps1')}"
```

```
chezmoi init git@github.com:jtbrough/dotfiles.git
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
