#!/usr/bin/env bash

wget -O- "https://raw.githubusercontent.com/aayko/.dotfiles/main/private_dot_ssh/encrypted_id_rsa.pub.age" | age --decrypt --identity /home/ayko/.age/key > /home/ayko/.ssh/id_rsa.pub &&
wget -O- "https://raw.githubusercontent.com/aayko/.dotfiles/main/private_dot_ssh/encrypted_private_id_rsa.age" | age --decrypt --identity /home/ayko/.age/key > /home/ayko/.ssh/id_rsa &&
mkdir -p /home/"$USER"/.config/chezmoi &&
cat > /home/ayko/.config/chezmoi/chezmoi.toml <<-EOF
encryption = "age"
[age]
    identity = "/home/ayko/.age/key"
    symmetric = true
[git]
    autoCommit = true
    autoPush = true
EOF
chezmoi init git@github.com:aayko/.dotfiles &&
chezmoi update
