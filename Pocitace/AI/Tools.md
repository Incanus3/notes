### AI chat
- https://t3.chat/ - a really good alternative to ChatGPT
	- choose any model
	- $8/month
### Coding agents
- https://opencode.ai/ - CLI (command & interactive) & web interface
	- integrates with most model providers and backends (both cloud and local)
- https://www.warp.dev/ - AI terminal + CLI (non-interactive)
	- just a few selected models, but mostly SOTA
- https://www.augmentcode.com - IDE plugin + CLI (command & interactive)
	- good prompt enhancement and project indexing
	- pretty good price for SOTA models (much cheaper Claude)
	- doesn't work with latest IDEA
- https://kilo.ai/ - very versatile
	- lots of front-ends - CLI, IDE plugins, cloud agents, app builder, slack, code review
	- provides most models, either through own subscription, or bring your key
	- pricing (if subsription bought from them) is almost the same as if used directly by provider
	- VS Code seems to be the primary plugin target, JetBrains plugin has a few issues, but is definitely usable
	- plugin shows A LOT of usage information (unlike most alternatives)
	- no prompt enhancement or project indexing
	- not as cheap as augment for SOTA models
	- https://github.com/Kilo-Org/kilocode/issues/2538 - workaround to set font size in JetBrains kilo extension
	- to work around JB bug where you can't copy external providers' tokens into the inputs, enter some recognizable shit there (xxxxx), then edit ~/.kilocode/secrets.json and replace it by the actual token
- https://refact.ai - IDE plugin
	- similar, but augment worked much better for me
- https://tidewave.ai/ - the coding agent for full-stack web app development 
	- very interesting integrations - can introspect most parts of your app
	- doesn't support java/kotlin yet - supports JS, python, ruby, elixir
- https://cursor.com/home - the AI IDE
	- probably the most popular AI-first IDE
	- built on top of VS code (sadly pretty broken in wayland)
- https://www.vibekanban.com/ - manage agent tasks as a kanban board
	- supports a lot of backends, including opencode, which supports most providers
- https://github.com/AutoMaker-Org/automaker
	- similar, nicer UI, but seems more suited for one-off jobs than for interactive work
	- doesn't support as many backends, but is adding new ones gradually
- https://github.com/different-ai/openwork - turn your opencode workflows into usable experiences for non-technical users
- https://claude.com/product/claude-code - CLI and IDE plugin directly from Claude
	- haven't tried, but at least CLI should be good enough (pretty popular)
	- pretty good price, generous token limits, but only Claude models
- https://openai.com/codex/ - OpenAI coding agents - CLI, web, IDE (cursor, JetBrains, VS Code), Warp
	- haven't tried, should be usable
	- only OpenAI models, don't know about token limits

NOTE: to use tui agents effectively on windows, you need a terminal which can manage these highly interactive tuis, e.g. updating a line that's been scrolled off the screen
- warp handles this fine, alacritty and hyper should work too
#### Extensions
- https://btca.dev/ - better context for your agents
	- ask questions about your libs
	- works directly with their code
- https://github.com/numman-ali/openskills - synchronize skills btw backends
### Cloud services
- https://www.daytona.io - run AI code in cloud sandbox
- https://sprites.dev/ - similar, but stateful
- https://www.coderabbit.ai/ - AI code review
- https://www.greptile.com/ - similar, maybe a bit better, but also more expensive
### Other stuff
- https://docs.sillytavern.app/ - locally installed user interface that allows you to interact with text generation LLMs, image generation engines, and TTS voice models
- https://github.com/steipete - there used to be LOTS of really cool projects here, but seems like his account has been taken over
	- [[steipete (Peter Steinberger) · GitHub.html]]