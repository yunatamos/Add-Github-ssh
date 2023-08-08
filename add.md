
Generate a new SSH key on your local machine.

Open a terminal
Enter the following command, replacing "your_email@example.com" with your GitHub email address.
mathematica
Copy code
ssh-keygen -t ed25519 -C "your_email@example.com"
When asked where to save the file, you can accept the default location by just pressing Enter. Alternatively, you can specify a different path.

You'll then be asked to enter a passphrase. It's recommended to use a strong passphrase for security reasons, but you can also press Enter to not use a passphrase.

Start the SSH agent and add your new SSH key to it.

In the terminal, enter the following commands:
bash
Copy code
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
Replace ~/.ssh/id_ed25519 with your own file path if you chose a custom location during key generation.
Copy your SSH key to the clipboard.

Install xclip if you don't have it:
arduino
Copy code
sudo apt-get install xclip
Copy the key to the clipboard:
javascript
Copy code
xclip -sel clip < ~/.ssh/id_ed25519.pub
Replace ~/.ssh/id_ed25519.pub with your own file path if you chose a custom location during key generation.
Add your SSH key to your GitHub account.

Log into GitHub and go to your account settings.

In the side menu, go to SSH and GPG keys.

Click on New SSH key or Add SSH key.

In the Title field, add a descriptive title for the new key. E.g. "My Personal Computer".

Paste your key into the Key field.

Click Add SSH key.

Test your SSH key.

In the terminal, enter the following command:
css
Copy code
ssh -T git@github.com
You may see a warning like this:
vbnet
Copy code
The authenticity of host 'github.com (IP ADDRESS)' can't be established.
RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
Are you sure you want to continue connecting (yes/no)?
Type yes.

If everything is set up correctly, you should get a message like:

vbnet
Copy code
Hi username! You've successfully authenticated, but GitHub does not provide shell access.
If you encounter problems, make sure your key is correctly added to your GitHub account and that your local SSH agent is running.
Please note that if you're using a Windows machine, the steps may be slightly different due to the different terminal environment. In such cases, you could use an SSH client such as PuTTY or the built-in SSH client in Git Bash.




