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

### Reusable prompt: systemd OpenSSH ssh-agent with deterministic socket

> Use this on an interactive Linux machine only. It is a request to configure that machine; it must not be executed merely by saving this note.

```text
Configure a systemd-managed OpenSSH ssh-agent with a deterministic socket path.

Requirements:
1. Inspect whether the system provides ssh-agent.socket and ssh-agent.service user units.
2. Prefer the packaged socket-activated units. Enable and start ssh-agent.socket, not the
 service directly. The service should start automatically on first socket use.
3. Determine my UID with `id -u`. The expected socket is
 /run/user/<UID>/ssh-agent.socket. Do not assume UID 1000 unless confirmed.
4. Create or update ~/.config/environment.d/ssh-agent.conf with:
 SSH_AUTH_SOCK=${XDG_RUNTIME_DIR}/ssh-agent.socket
5. Create or update ~/.config/hypr/custom/env.conf with:
 env = SSH_AUTH_SOCK,$XDG_RUNTIME_DIR/ssh-agent.socket
 Preserve all existing settings.
6. Add this as a global setting near the top of ~/.ssh/config, preserving existing config:
 IdentityAgent /run/user/<UID>/ssh-agent.socket
 Do not duplicate it if an equivalent setting already exists.
7. Do not remove existing SSH_ASKPASS settings; they remain useful for initially unlocking keys.
8. Verify:
 - ssh-agent.socket is enabled and active
 - the deterministic socket exists
 - SSH_AUTH_SOCK resolves to that socket in a fresh session
 - ssh-add can communicate with the agent
9. Do not read or print private keys, passphrases, tokens, or credential contents. Do not put a
 passphrase in commands or configuration. If a key must be loaded, tell me to run interactively:
 env SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket" ssh-add ~/.ssh/id_rsa
10. Explain that I must log out and back in, then restart desktop applications such as Emdash and
 Auggie so they inherit the new environment.
11. Do not commit, push, install packages, or alter unrelated configuration.
```

