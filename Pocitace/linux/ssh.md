### force ssh to use password authentication
ssh -o PreferredAuthentications=keyboard-interactive -o PubkeyAuthentication=no user@host

### ssh - limiting login attempts
http://serverfault.com/questions/275669/ssh-sshd-how-do-i-set-max-login-attempts

### Fix graphical ssh agent
- as per https://wiki.archlinux.org/title/SSH_keys#SSH_agents
	- add `AddKeysToAgent yes` to the top of `~/.ssh/config`
- as per https://wiki.archlinux.org/title/GNOME/Keyring#SSH_keys
	- install `gcr-4` if not installed
	- run `systemctl --user enable gcr-ssh-agent.service`
- as per https://wiki.archlinux.org/title/Environment_variables#Graphical_environment
	- add `export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"` to `~/.xprofile`
	