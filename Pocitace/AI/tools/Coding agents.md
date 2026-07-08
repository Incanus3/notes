### Coding agents / IDEs / CLIs
- https://opencode.ai/ - CLI (command & interactive) and web interface for coding agents.
	- Integrates with most model providers and backends, both cloud and local.
- https://www.warp.dev/ - AI terminal + non-interactive CLI.
	- Only selected models, but mostly SOTA.
- https://www.augmentcode.com - IDE plugin + CLI (command & interactive).
	- Good prompt enhancement and project indexing.
	- Pretty good price for SOTA models, much cheaper Claude access.
	- `auggie` CLI, unlike the IDE plugin, also supports subagents.
		- https://docs.augmentcode.com/cli/subagents - Augment CLI subagents documentation.
- https://kilo.ai/ - versatile agentic coding platform.
	- Lots of front-ends: CLI, IDE plugins, cloud agents, app builder, Slack, code review.
	- Provides most models through Kilo subscription or bring-your-own-key.
	- Pricing, if subscription bought from them, is almost the same as if used directly by provider, which is not great for SOTA models.
	- VS Code seems to be the primary plugin target; JetBrains plugin has a few issues, but is definitely usable.
	- Plugin shows A LOT of usage information, unlike most alternatives.
	- No prompt enhancement or project indexing.
	- Not as cheap as Augment for SOTA models.
	- https://github.com/Kilo-Org/kilocode/issues/2538 - workaround to set font size in JetBrains Kilo extension.
	- To work around JB bug where you can't copy external providers' tokens into inputs, enter some recognizable shit there (`xxxxx`), then edit `~/.kilocode/secrets.json` and replace it by the actual token.
- https://refact.ai - IDE plugin.
	- Similar category, but Augment worked much better for me.
- https://tidewave.ai/ - coding agent for full-stack web app development.
	- Very interesting integrations: can introspect most parts of your app.
	- Doesn't support Java/Kotlin yet; supports JS, Python, Ruby, Elixir.
- https://cursor.com/home - AI-first IDE built on VS Code.
	- Probably the most popular AI-first IDE.
	- Sadly pretty broken on Wayland.
- https://claude.com/product/claude-code - CLI and IDE plugin directly from Anthropic/Claude.
	- Haven't tried, but at least CLI should be good enough; pretty popular.
	- Pretty good price and generous token limits, but only Claude models.
- https://openai.com/codex/ - OpenAI coding agents for CLI, web, IDEs (Cursor, JetBrains, VS Code), and Warp.
	- Haven't tried, should be usable.
	- Only OpenAI models; token limits unclear.

### Agent multiplexers / terminals
- https://herdr.dev/ - agent multiplexer; one terminal for all your coding agents.
	- Runs each agent in its own real terminal on a server, survives SSH disconnects.
	- Supports Claude Code, OpenCode, Codex, and more. No Electron, no account, no telemetry.

### Agent task orchestration / UI
- https://www.vibekanban.com/ - manage agent tasks as a Kanban board.
	- Supports a lot of backends, including opencode, which supports most providers.
- https://github.com/AutoMaker-Org/automaker (last update 05/2026) - agent task UI/orchestrator.
	- Similar to Vibe Kanban, nicer UI, but seems more suited for one-off jobs than interactive work.
	- Doesn't support as many backends, but is adding new ones gradually.
- https://www.conductor.build/ - agent task/worktree UI.
	- Similar to Vibe Kanban, nice UI, macOS only.
- https://github.com/different-ai/openwork (last update 06/2026) - turn opencode workflows into usable experiences for non-technical users.
- https://ralph-tui.com/ - AI agent loop orchestrator.
	- https://skills.sh/subsy/ralph-tui - Ralph TUI skill page.
- https://emdash.sh/ - open-source desktop dashboard for running multiple coding agents in parallel, each in its own Git worktree.
	- Works with 25+ agent CLIs (Claude Code, Codex, Cursor, Amp, Gemini, etc.) with auto-detection.
	- MCP server support, built-in file editor. Open source, 1M+ downloads.
- https://github.com/darrenhinde/OpenAgentsControl (last update 03/2026) - plan-first AI agent framework with approval-based execution.

### Context / prompts / skills
- https://btca.dev/ - better context for agents.
	- Ask questions about your libraries.
	- Works directly with their code.
- https://shumerprompt.com/ - large prompt library.
- https://github.com/asgeirtj/system_prompts_leaks (last update 06/2026) - collection of leaked/extracted system prompts from AI products.
- https://github.com/numman-ali/openskills (last update 01/2026) - universal skills loader for AI coding agents.
- https://skills.sh/ - large skill library.
	- https://skills.sh/steveyegge/beads - Beads skill.
	- https://skills.sh/obra/superpowers - Superpowers skills collection.
	- https://skills.sh/obra/superpowers-skills/getting-started-with-skills - getting started with skills.
	- https://skills.sh/obra/episodic-memory/remembering-conversations - episodic memory / remembering conversations skill.

### Opencode ecosystem
- https://github.com/vtemian/micode (last update 06/2026) - Raspberry Pi OpenCode plugin.
- https://github.com/mtymek/opencode-obsidian (last update 05/2026) - embed OpenCode AI assistant directly in Obsidian sidebar.
- https://github.com/mohak34/opencode-notifier (last update 06/2026) - OpenCode plugin for desktop notifications and sounds on permission, completion, and error events.
- https://github.com/code-yeongyu/oh-my-opencode (last update 06/2026) - OpenCode/Codex agent harness for complex codebases.

### Terminal compatibility
- To use TUI agents effectively on Windows, use a terminal that can manage highly interactive TUIs, for example updating a line that's been scrolled off screen.
	- Warp handles this fine; Alacritty and Hyper should work too.

### Misc / review later
- https://www.openportal.space/ - needs later inspection/classification.
