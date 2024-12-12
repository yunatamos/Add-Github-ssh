#!/bin/bash

# Function to setup SSH keys and configs for a GitHub account
setup_github_account() {
    local email=$1
    local account_name=$2

    echo "Setting up GitHub account for $account_name ($email)"
    
    # Generate SSH key
    ssh-keygen -t ed25519 -C "$email" -f ~/.ssh/id_ed25519_$account_name -N ""
    
    # Add configuration to SSH config file
    if [ ! -f ~/.ssh/config ]; then
        touch ~/.ssh/config
        chmod 600 ~/.ssh/config
    fi
    
    echo "
# $account_name GitHub account
Host github.com-$account_name
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_$account_name" >> ~/.ssh/config
    
    # Start SSH agent if not running
    eval "$(ssh-agent -s)"
    
    # Add key to SSH agent
    ssh-add ~/.ssh/id_ed25519_$account_name
    
    # Copy public key to clipboard if xclip is available
    if ! command -v xclip &> /dev/null; then
        sudo apt-get install -y xclip
    fi
    
    xclip -sel clip < ~/.ssh/id_ed25519_$account_name.pub
    
    echo "
Public key for $account_name has been copied to clipboard.
Please add it to GitHub:
1. Go to GitHub → Settings → SSH and GPG keys
2. Click 'New SSH key'
3. Paste the key and save
"
    
    # Wait for user to add key to GitHub
    read -p "Press Enter after adding the key to GitHub..."
    
    # Test connection
    ssh -T git@github.com-$account_name
    
    # Set local Git config for a directory
    read -p "Enter directory path for $account_name's projects (e.g., ~/projects/$account_name): " project_dir
    
    # Create directory if it doesn't exist
    mkdir -p "$project_dir"
    
    # Set Git config for the directory
    cd "$project_dir"
    git config user.name "$account_name"
    git config user.email "$email"
    
    echo "
Setup completed for $account_name:
- SSH key generated
- SSH config updated
- Key added to SSH agent
- Git config set in $project_dir
"
}

# Main script
echo "GitHub Multiple Account Setup Script"
echo "==================================="

# Setup first account
setup_github_account "test1@example.com" "test1"

# Ask if user wants to add another account
while true; do
    read -p "Do you want to add another GitHub account? (y/n): " answer
    case $answer in
        [Yy]* )
            read -p "Enter email for new account: " email
            read -p "Enter account name: " account_name
            setup_github_account "$email" "$account_name"
            ;;
        [Nn]* )
            break
            ;;
        * )
            echo "Please answer y or n."
            ;;
    esac
done

echo "
Setup complete! Here's how to use your configurations:

To clone repositories:
git clone git@github.com-ACCOUNTNAME:username/repo.git

Example:
git clone git@github.com-test1:test1/repo.git

Remember to clone repositories from the corresponding project directories to use the correct Git configs.
"
