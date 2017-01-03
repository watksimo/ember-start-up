
# Create user
username="$1"
pass="$1"
grep -q "$username" /etc/passwd
if [ $? -eq 0 ]
then
    echo "User $username already exists."
else
    useradd -p `mkpasswd "$pass"` -d /home/"$username" -m -g users -s /bin/bash "$username"
    echo "$username  ALL=(ALL:ALL) ALL" >> /etc/sudoers
    echo "Account $username is setup as sudoer."
fi

# Set vim config
(
cat <<'ENDVIMCONFIG'
set tabstop=4
set shiftwidth=4
set expandtab
colorscheme desert
ENDVIMCONFIG
) > /home/"$username"/.vimrc

# Set tmux config
(
cat <<'ENDTMUXCONFIG'
# Enable mouse control (clickable windows, panes, resizable panes)
# disable mouse control by default - change 'off' to 'on' to enable by default.
setw -g mode-mouse off
set-option -g mouse-resize-pane off
set-option -g mouse-select-pane off
set-option -g mouse-select-window off
# toggle mouse mode to allow mouse copy/paste
# set mouse on with prefix m
bind m \
    set -g mode-mouse on \;\
    set -g mouse-resize-pane on \;\
    set -g mouse-select-pane on \;\
    set -g mouse-select-window on \;\
    display 'Mouse: ON'
# set mouse off with prefix M
bind M \
    set -g mode-mouse off \;\
    set -g mouse-resize-pane off \;\
    set -g mouse-select-pane off \;\
    set -g mouse-select-window off \;\
    display 'Mouse: OFF'
 
# split panes using | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %
 
# vi mode
set-window-option -g mode-keys vi
bind-key -t vi-copy 'v' begin-selection
bind-key -t vi-copy 'y' copy-selection
 
# status bar
set -g status-justify left
set -g status-bg default
set -g status-fg colour12
 
# pane resize binds
bind j resize-pane -R 10
bind k resize-pane -U 10
bind l resize-pane -D 10
bind h resize-pane -L 10
 
# toggle async of input across all panes
bind a set-window-option synchronize-panes
ENDTMUXCONFIG
) > /home/"$username"/.tmux.conf

# Set bashrc config
(
cat <<'ENDBASHCONFIG'
# Change directory colour in `ls`
LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS
 
force_color_prompt=yes
 
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
 
export PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\]$(__git_ps1)\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] >\[\033[0m\] '
ENDBASHCONFIG
) > /home/"$username"/.bashrc

