# minimal-prompt

## How it looks:

![Screenshot](./minimal-prompt.png "Awesome Prompt!")

## Install

To use this, put `minimal-prompt.zsh` in your favourite location and source it 
in your `.zshrc`.

```bash
# Automatic (Arch)
make prepare
makepkg -si
echo 'source "/usr/share/zsh/plugins/minimal-prompt.zsh"' >> .bashrc

# Manual
sudo make install
echo 'source "/usr/share/zsh/plugins/minimal-prompt.zsh"' >> .bashrc
```

You can either use a Nerd Font, or use different characters setting the
following variables:

| **VARIABLE**                  | **DEFAULT**        |
| :---------------------------: | :----------------: |
| `MINPROMPT_GIT_AHEAD`         | "+"                |
| `MINPROMPT_GIT_BEHIND`        | "-"                |
| `MINPROMPT_GIT_UNTRACKED`     | "%{$fg[red]%}"    |
| `MINPROMPT_GIT_MODIFIED`      | "%{$fg[yellow]%}" |
| `MINPROMPT_GIT_CACHED`        | "%{$fg[green]%}"  |
| `MINPROMPT_GIT_PREFIX`        | "%{$fg[red]%}["    |
| `MINPROMPT_GIT_SUFFIX`        | "%{$fg[red]%}]"    |
| `MINPROMPT_GIT_BRANCH_SYMBOL` | ""                |
| `MINPROMPT_CHAR_SYMBOL`       | ""                |
