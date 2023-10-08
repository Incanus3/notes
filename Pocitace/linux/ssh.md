- force ssh to use password authentication
ssh -o PreferredAuthentications=keyboard-interactive -o PubkeyAuthentication=no user@host
