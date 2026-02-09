- https://ralph-tui.com/ - AI agent loop orchestrator
- https://skills.sh/subsy/ralph-tui - skills usable directly in agents
- facilitates
	- interactive task (PRD) creation
	- task selection, execution and monitoring

### How to get started
```sh
# set up a new repo
cd <project_dir>
jj git init --colocate
jj git remote add origin <repo_url>
jj bookmark set -r zzz main
jj bookmark track main

# start using ralph and beads
yay -S ralph-tui beads-bin
bd init
bd doctor --fix
jj commit -m "initialized beads"
ralph-tui setup
jj commit -m "initialized ralph-tui"
# make sure you have configured opencode/claude/codex and selected the model you're gonna use
ralph-tui create-prd --chat # when asked to create beads, say yes
# you can tell it to start immediately, or use
ralph-tui run/resume/status later
```

#### BD TUI (optional)
- don't use the bdui AUR package
```sh
cd ~/Install/
git clone https://github.com/assimelha/bdui.git
cd bdui/
bun install
bun run build
./bdui
cp bdui ~/.local/bin/
# make sure you have ~/.local/bin in path
```