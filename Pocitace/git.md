===== GitButler =====
- https://github.com/gitbutlerapp/gitbutler (last update 07/2026) - Git-based desktop and CLI client designed for AI-assisted workflows, with stacked/parallel branches, visual commit rewriting, an undo timeline, conflict handling, forge integration, and AI helpers for commits and PRs.

===== GitButler on Linux Wayland: diagnostic/fix prompt =====
'''
GitButler will not start on my Linux Wayland session. Please diagnose and fix it
without modifying the packaged application or changing global system graphics settings.
Context:
- GitButler is likely a Tauri/WebKitGTK app.
- On an NVIDIA + Wayland system, it may exit with:
Gdk-Message: Error 71 (Protocol error) dispatching to Wayland display.
- First reproduce the failure and inspect GitButler's stderr/logs.
- Test this narrow workaround before making it persistent:
__NV_DISABLE_EXPLICIT_SYNC=1 gitbutler-tauri
- If GitButler stays running and its UI starts normally, persist only this setting
through a per-user desktop-entry override:
~/.local/share/applications/GitButler.desktop
The override should use the same fields as the packaged GitButler.desktop entry, but
set:
Exec=env __NV_DISABLE_EXPLICIT_SYNC=1 gitbutler-tauri
Then:
1. Validate it with desktop-file-validate.
2. Refresh the user desktop database with update-desktop-database.
3. Launch it via the normal desktop-entry path (for example, gtk-launch GitButler)
and verify that GitButler remains running and logs no Wayland protocol error.
Do not use GDK_BACKEND=x11 unless the NVIDIA explicit-sync workaround fails: I want
native Wayland and the faster DMA-BUF renderer preserved.
If __NV_DISABLE_EXPLICIT_SYNC=1 starts the app but causes visual artifacts, test the
fallback:
WEBKIT_DISABLE_DMABUF_RENDERER=1 gitbutler-tauri
Explain that it disables WebKitGTK's DMA-BUF renderer and may reduce UI rendering
performance before persisting it instead.
'''

===== git config =====
user.name=Jakub Kalab
user.email=jakub.kalab@friendlysystems.cz
color.ui=true
alias.s=status
alias.a=add
alias.d=diff
alias.c=commit
alias.ds=diff --staged
alias.l=log
alias.ls=log --stat
alias.onelog=log --format=format:"%Cblue%h   %Cgreen%ar%x09%Creset%s"

===== commands =====
'''
git init					# init repo
git clone <url> [<dirname>]			# clone repo
git status					# show changed, staged and untracked files
git add (--all | (<file> | <dir>)*)		# globbing, *.txt - current dir, "*.txt" - recursive
git commit [-a, all changes] [--amend, add to last commit] [-m "message"]
git log
git diff  <files>				# diff working area against stage
git diff <commit> <files>			# diff working area against commit
git diff --staged [<commit>]     		# diff stage against commit
git branch					# list branches
git branch <name>				# create new branch
git reset [-p, interactively select changes] [<tree-ish>, default: HEAD] <files>                   # unstage files
git reset [<mode>] [<commit>]		# reset head to <commit> (e.g. HEAD^), possibly updating index (stage) or working tree depending on mode
# <mode> - one of --soft (just reset head), --mixed (index), --hard (index and working tree), --merge, --keep
git checkout [-p] [<tree-ish>] [—] <files>	# blow away changes in files up to <tree-ish>
git checkout [-b, create new] <branch>		# switch to <branch>
git remote -v					# show remote repos
git remote add <name> <git url>			# add remote
git remote rm <name>				# remove remote
git push [-u <remote> <branch>]			# push changes to remote
git pull					# pull changes from remote
git describe					# show most current tag
'''


git bisect (start | good | bad) - find commit that introduced error by binary search

<tree-ish> - commit, tag or tree
           Indicates a tree, commit or tag object name. A command that takes a <tree-ish> argument ultimately wants to operate on a <tree> object but automatically dereferences <commit> and <tag>
           objects that point at a <tree>.

* rewrite commit history
git filter-branch --env-filter '
                   if test "$GIT_AUTHOR_EMAIL" = "magiess@volny.com"
                   then
                           GIT_AUTHOR_EMAIL=magiess@volny.cz
                           export GIT_AUTHOR_EMAIL
                   fi
           ' -- --all
