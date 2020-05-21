#!/bin/bash

__create_user() {
# Create a user to SSH into server for accessing remote git server.
useradd git
SSH_USERPASS=git
SSH_ROOTPASS=123456
echo -e "$SSH_USERPASS\n$SSH_USERPASS" | (passwd --stdin git)
echo ssh git user password is : $SSH_USERPASS
}

__ssh_setup() {
# Verificaton of the initialisation of the home
if [ -f "/home/git/.ssh)" ]; then
     echo "The directory .ssh exists. Nothing to do."
else
    echo "The directory .ssh doesn't exist, generating files..."
    # Creating authorized_keys file
    mkdir /home/git/.ssh
    touch /home/git/.ssh/authorized_keys
    echo "Done."
fi

# Rights
chmod 755 /home/git/.ssh
chmod 644 /home/git/.ssh/authorized_keys
chown -R git:git /home/git
}

__create_user
__ssh_setup