- `ls -l | where size > 1kb | sort-by size | reverse`
- `ps | where status not-in [Sleeping, Unknown]`
- `ps | describe` - prints type of the output
	- > `table<pid: int, ppid: int, name: string, status: string, cpu: float, mem: filesize, virtual: filesize> (stream)`
- `^ps aux` - external (non-tabular) command
- `ls | sort-by size | reverse | first | get name | cp $in ~` - use stdin as param

```nu
http get --headers [PRIVATE-TOKEN $token] "https://qmachine.link/api/v4/users/43/events?after=2025-10-05T00:00:00Z&per_page=100"
| select -o created_at action_name push_data.ref push_data.commit_title target_title
```