
ssh-keygen -t ed25519 -C "your_email@example.com"

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

sudo apt-get install xclip
xclip -sel clip < ~/.ssh/id_ed25519.pub
ssh -T git@github.com
