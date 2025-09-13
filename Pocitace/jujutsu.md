### Commands
#### change management
- `jj new`
	- creates a new change, empty and undescribed by default
	- `-m "message"` set the message directly
- `jj describe`
	- describes a change, by default opens editor to write the message
	- `-m "message"` set the message directly
- `jj squash`
	- move changes from current change into the parent one (by default)
	- by default, moves all changes
	- can take file(set)s
	- `-i` interactive
#### informative
- `jj status`
	- shows repo status
	- `--no-pager`
- `jj log`
	- prints the change log
#### configuration
- `jj git init`
	- initializes a new repo with git as storage
	- `--colocate` - use existing git repo - git commands can be used alongside `jj`
- `jj config`
	- get/set config options