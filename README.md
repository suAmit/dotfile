# Termux Setup Guide

> This repo uses a bare git repository setup following the [Atlassian dotfiles tutorial](https://www.atlassian.com/git/tutorials/dotfiles)

## Table of Contents

1. [Termux Setup](#termux-setup)

   - [Initial Setup](#initial-setup)
   - [Phantom Process Killer Fix](#phantom-process-killer-fix-optional)
   - [Termux Style Customization](#termux-style-customization)
   - [Accessing proot-distro Files](#accessing-proot-distro-files)

2. [proot-distro Alpine Setup](#proot-distro-alpine-setup)

   - [Installation](#installation)
   - [User Configuration](#user-configuration)
   - [Storage Access](#storage-access)

3. [Development Environment](#development-environment)

   - [Neovim Install](#neovim-install)
   - [Vim Install](#vim-install)
   - [Tmux Install](#tmux-install)
   - [Shell Install](#shell-install)
   - [Zsh Customization](#zsh-customization)

4. [Vim Keybindings](#vim-keybindings)

   - [Default Vim Navigation](#default-vim-navigation)
   - [Editing and Manipulation](#editing-and-manipulation)
   - [Visual Mode and Selections](#visual-mode-and-selections)
   - [Search and Replace](#search-and-replace)
   - [Window and Tab Management](#window-and-tab-management)
   - [File Management Commands](#file-management-commands)
   - [Session and Workspace Management](#session-and-workspace-management)
   - [Buffer and Window Management](#buffer-and-window-management)
   - [Miscellaneous Commands](#miscellaneous-commands)

5.[Tmux Keybindings](#tmux-keybindings)

   - [Session Management](#session-management)
   - [Window Management](#window-management)
   - [Pane Management](#pane-management)
   - [Resizing Panes](#resizing-panes)
   - [Copy Mode and Buffers](#copy-mode-and-buffers)
   - [Command Mode](#command-mode)

6. [Quick Setup Commands](#quick-setup-commands)
   - [Termux Initial Setup](#termux-initial-setup)
   - [Proot Setup](#proot-setup)
   - [Development Tool Install](#development-tool-install)

---

## Termux Setup

### Initial Setup

Update packages and set up local storage with the following commands:

```bash
# Update and upgrade packages
yes | pkg upgrade && yes | pkg update

# Install required packages
pkg install proot-distro git

# Set up local storage access
termux-setup-storage
```

---

### Phantom Process Killer Fix (Optional)

Android's phantom process killer can terminate Termux, disrupting background processes and servers.

To prevent this:

1. Enable Developer Options on your Android device
2. Search for "background process limit"
3. Set it to "No background process limit"

For detailed instructions, see this [video guide](https://youtu.be/vK1Jx9ydi5c).

---

### Termux Style Customization

Remove default keyboard settings and customize your Termux appearance:

```bash
mv ~/.termux .termux-backup
git clone https://github.com/suAmit/termux-dotfile.git ~/.termux
```

Alternative styling options:

- [myTermux](https://github.com/mayTermux/myTermux)
- [termux-style](https://github.com/adi1090x/termux-style)

---

### Accessing proot-distro Files

Create a symlink to access installed rootfs from your home directory:

```bash
ln -rs $PREFIX/var/lib/proot-distro/installed-rootfs $HOME/proot-distro-rootfs
```

---

## proot-distro Alpine Setup

Alpine Linux is chosen for its lightweight nature, security features, and efficiency with limited resources.

### Installation

1. Install Alpine:

```bash
proot-distro install alpine
```

2. Login to Alpine:

```bash
proot-distro login alpine
```

3. Update system:

```bash
apk upgrade && apk update
```

4. Install sudo:

```bash
apk add sudo
apk upgrade && apk update
```

---

### User Configuration

1. Set root password:

```bash
passwd
```

2. Create a new user (replace 'stark' with desired username):

```bash
adduser stark
```

3. Configure sudo access:

```bash
nano /etc/sudoers
```

Add the following line under "root ALL=(ALL:ALL) ALL":

```
stark ALL=(ALL:ALL) ALL
```

4. Switch to the new user:

```bash
su stark
cd
```

5. Verify user switch:

```bash
whoami
```

6. Direct user login command:

```bash
proot-distro login --user stark alpine
```

---

### Storage Access

Link phone storage to proot-distro:

```bash
ln -s /data/data/com.termux/files/home/storage phone-storage
```

Link termux storage to proot-distro:

```bash
ln -s /data/data/com.termux/files/home termux-storage
```

---

## Development Environment

### Neovim Install

1. Install Neovim:

```bash
apk add neovim
```

Popular configuration options:

- [NvChad](https://nvchad.com) - Lightweight and fast
- [LazyVim](https://www.lazyvim.org) - Full IDE setup

---

### Vim Install

1. Install vim:

```bash
apk add vim
```

---

### Tmux Install

1. Install Tmux:

```bash
apk add tmux
```

---

### Shell Install

1. Install Zsh:

```bash
apk add zsh
```

2. Set Zsh as default shell:

```bash
nvim /etc/passwd
```

3. Locate your user entry and change the default shell path to `/bin/zsh`

---

### Zsh Customization

1. Install oh-my-zsh:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

2. Install powerlevel10k (Optional):

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

3. For powerlevel10k configuration, follow the [official documentation](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#configuration-wizard)

---

## Tmux Keybindings

Note: Default prefix is `Ctrl + b`

### **Session Management**

| Keybinding                    | Action                               |
| ----------------------------- | ------------------------------------ |
| `Ctrl-b $`                    | Rename the current session           |
| `Ctrl-b d`                    | Detach from the current session      |
| `Ctrl-b s`                    | List all sessions                    |
| `tmux attach -t [name]`       | Attach to a specific session by name |
| `tmux kill-session -t [name]` | Kill a specific session              |

---

### **Window Management**

| Keybinding | Action                        |
| ---------- | ----------------------------- |
| `Ctrl-b c` | Create a new window           |
| `Ctrl-b ,` | Rename the current window     |
| `Ctrl-b n` | Switch to the next window     |
| `Ctrl-b p` | Switch to the previous window |
| `Ctrl-b w` | List all windows              |
| `Ctrl-b &` | Kill the current window       |

---

### **Pane Management**

| Keybinding | Action                              |
| ---------- | ----------------------------------- |
| `Ctrl-b %` | Split the current pane vertically   |
| `Ctrl-b "` | Split the current pane horizontally |
| `Ctrl-b o` | Switch to the next pane             |
| `Ctrl-b q` | Show pane numbers                   |
| `Ctrl-b x` | Kill the current pane               |
| `Ctrl-b {` | Swap with the previous pane         |
| `Ctrl-b }` | Swap with the next pane             |
| `Ctrl-b z` | Toggle zoom for the current pane    |

---

### **Resizing Panes**

| Keybinding               | Action                |
| ------------------------ | --------------------- |
| `Ctrl-b :resize-pane -L` | Resize the pane left  |
| `Ctrl-b :resize-pane -R` | Resize the pane right |
| `Ctrl-b :resize-pane -U` | Resize the pane up    |
| `Ctrl-b :resize-pane -D` | Resize the pane down  |

---

### **Copy Mode and Buffers**

| Keybinding                   | Action                          |
| ---------------------------- | ------------------------------- |
| `Ctrl-b [`                   | Enter copy mode                 |
| `Space`                      | Start selection in copy mode    |
| `Enter`                      | Copy the selected text          |
| `Ctrl-b ]`                   | Paste from Tmux buffer          |
| `Ctrl-b :show-buffer`        | Show the contents of the buffer |
| `Ctrl-b :save-buffer [file]` | Save buffer to a file           |
| `Ctrl-b :delete-buffer`      | Delete the buffer               |

---

### **Command Mode**

| Keybinding | Action                      |
| ---------- | --------------------------- |
| `Ctrl-b :` | Enter Tmux command prompt   |
| `Ctrl-b ~` | Show command prompt history |

---

## Vim Keybindings

### Default Vim Navigation

| Keybinding | Action                                     |
| ---------- | ------------------------------------------ |
| `h j k l`  | Move cursor left, down, up, right          |
| `w`        | Jump to start of next word                 |
| `b`        | Jump to start of previous word             |
| `e`        | Jump to end of current/next word           |
| `0`        | Jump to start of line                      |
| `$`        | Jump to end of line                        |
| `gg`       | Go to first line of document               |
| `G`        | Go to last line of document                |
| `{`        | Jump to previous paragraph/code block      |
| `}`        | Jump to next paragraph/code block          |
| `CTRL-u`   | Move up half a screen                      |
| `CTRL-d`   | Move down half a screen                    |
| `CTRL-b`   | Move up one full screen                    |
| `CTRL-f`   | Move down one full screen                  |
| `%`        | Jump to matching bracket                   |
| `*`        | Search for word under cursor (forward)     |
| `#`        | Search for word under cursor (backward)    |
| `fx`       | Jump to next occurrence of character x     |
| `Fx`       | Jump to previous occurrence of character x |

---

### Editing and Manipulation

| Keybinding | Action                                         |
| ---------- | ---------------------------------------------- |
| `i`        | Enter insert mode before cursor                |
| `I`        | Enter insert mode at the beginning of the line |
| `a`        | Enter insert mode after cursor                 |
| `A`        | Enter insert mode at the end of the line       |
| `o`        | Open a new line below the current line         |
| `O`        | Open a new line above the current line         |
| `x`        | Delete character under cursor                  |
| `dd`       | Delete the current line                        |
| `D`        | Delete from cursor to end of line              |
| `yy`       | Copy the current line                          |
| `p`        | Paste after the cursor                         |
| `P`        | Paste before the cursor                        |
| `u`        | Undo the last action                           |
| `CTRL-r`   | Redo the last undone action                    |

---

### Visual Mode and Selections

| Keybinding | Action                                       |
| ---------- | -------------------------------------------- |
| `v`        | Start visual mode (select characters)        |
| `V`        | Start line visual mode (select entire lines) |
| `CTRL-v`   | Start visual block mode (select block)       |
| `y`        | Yank (copy) the selected text                |
| `d`        | Delete the selected text                     |
| `>`        | Indent selected text to the right            |
| `<`        | Indent selected text to the left             |
| `~`        | Toggle case of the selected text             |

---

### Search and Replace

| Keybinding      | Action                                      |
| --------------- | ------------------------------------------- |
| `/`             | Start a forward search                      |
| `?`             | Start a backward search                     |
| `n`             | Move to the next search result              |
| `N`             | Move to the previous search result          |
| `:%s/old/new/g` | Replace all occurrences of "old" with "new" |
| `:s/old/new/g`  | Replace in the current line only            |

---

### Window and Tab Management

| Keybinding | Action                          |
| ---------- | ------------------------------- |
| `:sp`      | Split window horizontally       |
| `:vsp`     | Split window vertically         |
| `CTRL-w h` | Move to the window on the left  |
| `CTRL-w j` | Move to the window below        |
| `CTRL-w k` | Move to the window above        |
| `CTRL-w l` | Move to the window on the right |
| `:q`       | Quit the current window         |
| `:wq`      | Save and quit                   |
| `:qa`      | Quit all windows                |
| `:tabnew`  | Open a new tab                  |
| `:tabn`    | Switch to the next tab          |
| `:tabp`    | Switch to the previous tab      |

---

### File Management Commands

| Keybinding         | Action                                                    |
| ------------------ | --------------------------------------------------------- |
| `:e filename`      | Open a file                                               |
| `:w`               | Save the current file                                     |
| `:wq`              | Save and quit                                             |
| `:q`               | Quit the current window                                   |
| `:q!`              | Quit without saving                                       |
| `:w!`              | Save the current file even if it’s read-only              |
| `:e!`              | Reload the current file                                   |
| `:x`               | Save and quit (similar to `:wq`)                          |
| `:Vex!`            | Open a file in a vertical split, forcing a reload         |
| `:vsp filename`    | Open a file in a vertical split                           |
| `:sp filename`     | Open a file in a horizontal split                         |
| `:tabnew filename` | Open a file in a new tab                                  |
| `:ls`              | List all buffers                                          |
| `:b {n}`           | Switch to buffer `{n}` (where `{n}` is the buffer number) |
| `:bd`              | Close the current buffer                                  |

---

### Session and Workspace Management

| Keybinding            | Action                                           |
| --------------------- | ------------------------------------------------ |
| `:mksession`          | Save the current session to a file               |
| `:source session.vim` | Load a saved session                             |
| `:qa`                 | Quit all windows                                 |
| `:qa!`                | Quit all windows without saving                  |
| `:wa`                 | Write (save) all open files                      |
| `:args`               | List all files in the argument list              |
| `:argdelete`          | Remove a file from the argument list             |
| `:next`               | Switch to the next file in the argument list     |
| `:prev`               | Switch to the previous file in the argument list |

---

### Buffer and Window Management

| Keybinding | Action                                         |
| ---------- | ---------------------------------------------- |
| `CTRL-w h` | Move to the window on the left                 |
| `CTRL-w j` | Move to the window below                       |
| `CTRL-w k` | Move to the window above                       |
| `CTRL-w l` | Move to the window on the right                |
| `:split`   | Split the current window horizontally          |
| `:vsplit`  | Split the current window vertically            |
| `:close`   | Close the current window                       |
| `:only`    | Close all other windows except the current one |

---

### Miscellaneous Commands

| Keybinding            | Action                     |
| --------------------- | -------------------------- |
| `:help`               | Open Vim help              |
| `:set nu`             | Show line numbers          |
| `:set nonu`           | Hide line numbers          |
| `:set relativenumber` | Show relative line numbers |
| `:set ignorecase`     | Ignore case in search      |
| `:set smartcase`      | Enable smart case search   |
| `:version`            | Show version information   |
| `:history`            | Show command history       |
| `:command`            | List user-defined commands |

---

## Quick Setup Commands

### Termux Initial Setup

```bash
yes | pkg upgrade && yes | pkg update && yes | pkg install proot-distro git && mv ~/.termux .termux-backup ; git clone https://github.com/suAmit/termux-dotfile.git ~/.termux && termux-setup-storage
```

---

### Proot Setup

Follow the user configuration steps [above](#user-configuration) to complete the proot setup and add users.

---

### Development Tool Install

- Install development Tool

```bash
apk add neovim tmux vim zsh
```

- Set Zsh as default shell

```bash
nvim /etc/passwd
```

- Install oh-my-zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- Install powerlevel10k (Optional)

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
