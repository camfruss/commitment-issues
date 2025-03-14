#!/bin/bash

set -e

SSH_KEY=$HOME/.ssh/id_ed25519

ENV_PATH=$HOME/.env
touch "$ENV_PATH"

# If running on Linux, replace with {sed -r -n} 
gh auth login
USERNAME=$(gh auth status | sed -n -E "s/.*account ([^ ]*) .*/\1/p")

# (Creates) and retreives PAT from .env file
echo "Retreiving personal access token..."
if PAT=$(sed -n 's/^GH_PAT=//p' $HOME/.env); then
else
	PAT=$(gh auth token create --scopes "repo, write:public_key, admin:public_key")
	echo "GH_PAT=$PAT" >> "$ENV_PATH"
fi
export GITHUB_TOKEN="$PAT"

if [[ ! -f $SSH_KEY"" ]]; then
	echo "Generating SSH key"
	
	ssh-keygen -t ed25519 -C "$USERNAME@github" -f "$SSH_KEY" -N ""
    eval "$(ssh-agent -s)"
    ssh-add "$SSH_KEY"
fi

PUBLIC_KEY=$(cat "$SSH_KEY.pub")
if gh ssh-key list | grep -Fq "$PUBLIC_KEY"; then 
else
	echo "Adding SSH key to GitHub..."

	gh ssh-key add ~/.ssh/id_ed25519.pub
fi

echo "Complete."
