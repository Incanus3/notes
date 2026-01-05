- force ssh to use password authentication
ssh -o PreferredAuthentications=keyboard-interactive -o PubkeyAuthentication=no user@host

== ssh - limiting login attempts ==
http://serverfault.com/questions/275669/ssh-sshd-how-do-i-set-max-login-attempts
