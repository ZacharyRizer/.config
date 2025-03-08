#!/bin/bash

echo "Creating a new TMUX session."
read -p "Enter the name of the session: " session_name

tmux new -s $session_name -d
tmux split-window -v -t $session_name

tmux new-window -t $session_name
tmux send-keys -t $session_name 'nvim' Enter

tmux new-window -t $session_name
tmux send-keys -t $session_name 'lazygit' Enter

tmux select-window -t $session_name:2
