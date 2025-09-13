## Commands
#### change management
- `jj new`- creates a new change, empty and "undescribed" by default
	- `-m "message"` set the starting message
	- `-B <rev>` create the change before `<rev>`
	- `-A <rev>` create the change after `<rev>`
	- can take one or more parent rev-sets
		- if the parent already has a child, this will create a branching
- `jj describe`- describes a change, by default opens editor to write the message
	- `-m "message"` set the message directly
- `jj edit <rev>` - switch (move `@`) to `<rev>` to continue editing it
- `jj next` - switch (move `@`) to the child of current `@`
	- by default, makes a `new` change on top of it
	- `--edit` don't make a new change - continue editing the existing one
- `jj squash`- move changes from current change into the parent one (by default)
	- by default, moves all changes
	- can take file(set)s
	- `-i` interactive
	- default (no rev-set specified) is equal to `-r @` or `--from @ --into @-`
#### informative
- `jj status`
	- shows repo status
	- `--no-pager`
- `jj log`
	- prints the change log
	- `-r` - which revisions to show, e.g.:
		- `jj log -r 'heads(all())'` will print all heads
#### configuration
- `jj git init`
	- initializes a new repo with git as storage
	- `--colocate` - use existing git repo - git commands can be used alongside `jj`
- `jj config`
	- get/set config options

## Rev-sets
- most commands take optional `-r <revset>` param, which defaults to `@`
- rev-sets can be
	- a symbol:
		- commit IDs - hex digits
		- change IDs - only letters g..z - never collide with commit ID
			- any unique prefix of ID can be used
		- `@` - current working change
	- an operator applied to other rev-sets
		- `<rev>-` - parent of `<rev>`
		- `x & y` - changes that are in both `x` and `y` (an intersection)
		- `x | y` - changes in either (a union)
		- `::x` - ancestors of `x`
		- `x::` - descendants of `x`
	- a function application
		- `root()` - the root change
		- `all()` - all visible changes (?)
		- `mine()` - all changes authored by current user
		- `parents(x)`
		- `ancestors(x)` - same as `::x`
		- `ancestors(x, depth)`
		- `heads(x)` - commits in `x` that are not ancestors of other commits in `x`
		- `description(x)`: commits that have `x` in their description