#!/bin/bash

echo "Creating a new TMUX session."
read -p "Enter the name of the session: " session_name
read -p "Enter nvm version to use: " nvm

tmux new -s $session_name -d
tmux rename-window -t $session_name Terminal
tmux send-keys -t $session_name "nvm use $nvm" Enter
tmux split-window -v -t $session_name
tmux send-keys -t $session_name "nvm use $nvm" Enter

tmux new-window -t $session_name
tmux rename-window -t $session_name NVIM
tmux send-keys -t $session_name "nvm use $nvm" Enter
tmux send-keys -t $session_name 'nvim' Enter

tmux new-window -t $session_name
tmux rename-window -t $session_name GIT
tmux send-keys -t $session_name "nvm use $nvm" Enter
tmux send-keys -t $session_name 'lazygit' Enter

tmux select-window -t $session_name:2
