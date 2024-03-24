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
