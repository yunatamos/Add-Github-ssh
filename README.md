# GitHub Multiple Account Setup Script

A bash script to automate the setup of multiple GitHub accounts on a single machine. This script handles SSH key generation, SSH configuration, and Git configuration for each account.

## Features

- Generates SSH keys for multiple GitHub accounts
- Configures SSH settings automatically
- Sets up separate Git configurations for different projects
- Copies public keys to clipboard for easy GitHub setup
- Tests SSH connections
- Creates separate project directories for each account
- Interactive setup process

## Prerequisites

- Git installed on your system
- Linux/Unix-based operating system
- `xclip` (will be automatically installed if missing)

## Installation

1. Download the script:
```bash
curl -O https://raw.githubusercontent.com/yourusername/github-setup/main/github-setup.sh
```

2. Make the script executable:
```bash
chmod +x github-setup.sh
```

## Usage

1. Run the script:
```bash
./github-setup.sh
```

2. Follow the interactive prompts:
   - Enter email address for each account
   - Enter account name
   - Add SSH key to GitHub when prompted
   - Specify project directory for each account

## Directory Structure

The script will create a directory structure like this:
```
~/projects/
├── account1/
│   └── (repositories for account1)
├── account2/
│   └── (repositories for account2)
```

## SSH Configuration

The script creates an SSH config file at `~/.ssh/config` with entries like:
```
# account1 GitHub account
Host github.com-account1
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_account1
```

## Repository Operations

### Cloning Repositories

Clone repositories using the account-specific host:
```bash
# For account1
git clone git@github.com-account1:username/repo.git

# For account2
git clone git@github.com-account2:username/repo.git
```

### Pushing to a Repository

For a new repository:
```bash
git init
git add .
git commit -m "your commit message"
git branch -M main
git remote add origin git@github.com-accountname:username/repo.git
git push -u origin main
```

For subsequent pushes:
```bash
git add .
git commit -m "your commit message"
git push
```

### Pulling from a Repository

For first time:
```bash
git clone git@github.com-accountname:username/repo.git
```

To update existing repository:
```bash
git pull
```

### Useful Commands

```bash
# Check remote URL
git remote -v

# Change remote URL if needed
git remote set-url origin git@github.com-accountname:username/repo.git

# Check current branch
git branch

# Check status
git status
```

## Troubleshooting

### SSH Connection Issues
1. Verify SSH key was added to GitHub:
```bash
ssh -T git@github.com-accountname
```

2. Check SSH agent has the key:
```bash
ssh-add -l
```

### Git Configuration Issues
1. Verify account configuration:
```bash
git config user.name
git config user.email
```

### Logout and Remove Configuration

To remove git configuration and logout:

1. Remove global git configuration:
```bash
# Remove user name
git config --global --unset user.name

# Remove email
git config --global --unset user.email

# Remove entire global config
rm ~/.gitconfig
```

2. Remove stored credentials:
```bash
# For Windows
git config --global --unset credential.helper

# For macOS
git config --global --unset credential.helper osxkeychain

# For Linux
git config --global --unset credential.helper cache
```

3. Remove SSH keys:
```bash
# List SSH keys
ssh-add -l

# Remove specific key
ssh-add -d ~/.ssh/id_ed25519

# Remove all keys
ssh-add -D
```

## Contributing

Feel free to submit issues and enhancement requests!

## Security Notes

- The script generates SSH keys without passphrase protection by default
- SSH keys are stored in `~/.ssh/`
- SSH config file permissions are set to 600 (user read/write only)

## License

MIT License - feel free to use and modify as needed.
