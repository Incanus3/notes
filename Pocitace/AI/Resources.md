# AI resources

## Learning & broad resources

### Videos / channels

- https://www.youtube.com/@t3dotgg - T3 / Theo channel with AI and software development videos.
- https://www.youtube.com/@AndrejKarpathy - Andrej Karpathy's channel with AI, ML, and LLM explanations.
- https://www.youtube.com/@AICodeKing - AI coding-focused YouTube channel.
- https://www.youtube.com/@aiexplained-official - AI Explained channel.
- https://www.youtube.com/watch?v=68BS5GCRcBo - AI-related video to review.
- https://x.com/ajitcodes/status/2078313818627907773 - X thread pointing to a free 2-hour Andrej Karpathy lecture and guide for building a first AI loop.
- https://bloomberg.github.io/foml/ - Foundations of Machine Learning course/materials.

### Blogs / newsletters / people

- https://steipete.me/ - Peter Steinberger's blog, often covering AI tooling and engineering.
- https://shumer.dev/blog - Matt Shumer's blog about AI and agents.
- https://simonwillison.net/ - Simon Willison's writing about LLMs, tools, and software engineering.
- https://every.to/newsletter - Every newsletter with AI/product/business writing.
- https://steve-yegge.medium.com/ - Steve Yegge's Medium posts, including AI agent/tooling essays.
- https://github.com/decodingai-magazine - Decoding AI GitHub organization with AI engineering content.

### Courses / books / curricula

- https://github.com/rohitg00/ai-engineering-from-scratch (last update 06/2026) - free open-source AI engineering curriculum with 503 lessons across math, ML, LLMs, tools, agents, and production systems.
- https://pragprog.com/titles/jwpaieng/a-common-sense-guide-to-ai-engineering/ - PragProg book *A Common-Sense Guide to AI Engineering*.
- https://agenticjumpstart.com/ - paid agentic AI course.

## Agentic engineering

### AI-native engineering practices

- https://drive.google.com/file/d/1IR7CddF_2FyQo_PdfBNTaEA50EGiVt2r/view - PDF backup of *The New SDLC With Vibe Coding*, a 51-page paper by Addy Osmani, Shubham Saboo, and Sokratis Kartakis on moving from ad-hoc prompting to agentic engineering.
- https://addyosmani.com/blog/intent-debt/ - Addy Osmani article on intent debt: missing written goals, constraints, and rationale that AI agents cannot reliably infer from code.
- https://beyond.addy.ie/ - Addy Osmani guide to moving beyond vibe coding toward production AI-assisted engineering with specs, verification, security, and human expertise.
- https://blog.bytebytego.com/p/a-practical-guide-to-becoming-an - ByteByteGo/Shah Rahman practical guide to AI-native engineering: context engineering, spec-driven development, critical verification, problem decomposition, and security guardrails.
- https://www.aihero.dev/a-complete-guide-to-agents-md - guide to `AGENTS.md` files for AI coding agents.
- https://developers.openai.com/api/docs/guides/prompt-guidance/ - OpenAI prompt guidance documentation.
- https://senkorasic.com/articles/ai-coding - AI coding article with links to more resources.
- https://x.com/NainsiDwiv50980/status/2074081151397073156 - thread on Claude Code repo structure as the real bottleneck: context ladder (CLAUDE.md → rules → skills → agents), ASKED vs FORCED enforcement, path-gated rules, agent memory, and local CLAUDE.md in danger zones.

### Agent harnesses, skills & developer tooling

- https://github.com/AI-Builder-Club/skills (last update 06/2026) - Claude Code plugin marketplace with skills for codebase harnesses and compounding agent loops / shared file-based memory. Related launch/context thread: https://x.com/jasonzhou1993/status/2067937943545897143
- https://doneyli.substack.com/p/i-built-my-own-observability-for - article about building observability for Claude Code / AI coding workflows.
- https://substack.com/@charliehills/note/c-237534376 - curated list of Claude Code resources.
- https://build-your-own-openclaw.kiyo-n-zane.com/ - tutorial/project for building an OpenClaw-like agent with tools, skills, memory, chat, and internet access.
- https://generativeprogrammer.com/p/12-agentic-harness-patterns-from - article extracting reusable agentic application design patterns from Claude Code's harness.
- https://youtu.be/A8mokin_YOs - video showcasing agent skills v1.1: /wayfinder (territory-mapping for large work), /research, /implement, /to-spec, /to-tickets.

### Agent loops, learning & autonomy

- https://x.com/AnatoliKopadze/status/2068328135611822149 - thread/article on AI loops: goals plus execution, verification, retained state, and hard stop conditions; contrasts Claude Code, GPT self-check patterns, and Mira Telegram automations, with practical cost/oversight cautions.
- https://x.com/AnatoliKopadze/status/2078106556634124335 - thread/article about Anthropic engineers building a full app with a three-agent plan/build/judge loop, cycling until the app works.
- https://x.com/0xRicker/status/2078148918173368411 - X thread on Karpathy's warning that agent loops can generate low-diversity garbage at scale without visibility and evaluation.
- https://addyo.substack.com/p/loop-engineering - Addy Osmani article on loop engineering for coding agents: scheduled discovery/triage, worktrees, skills, connectors, sub-agents, memory, and cost/oversight tradeoffs.
- https://x.com/ataiiam/status/2074501252268937703 - “Building a Moat: Self Learning Agents” thread on product moats from harvesting learning signals in users’ browser/application activity.
- https://addyo.substack.com/p/agentic-autonomy-levels - Addy Osmani article proposing two axes for agentic autonomy: agency of a single agent and orchestration skill across many agents, with verification deciding what level is safe.
- https://drive.google.com/file/d/1qzKI4DKnyHRpXK1J3ATPqwaqLc0iNu-M/view - PDF backup of *Loop Engineering*, an IEEE article/book PDF on loop engineering.
- https://kenhuangus.substack.com/p/recursive-self-improvement-a-technical - technical deep dive on recursive self-improvement loops in AI systems, using Anthropic's "When AI builds itself" framing and Claude Code vs. Hermes Agent examples.
- https://x.com/akshay_pachaar/status/2054564519280804028 - link to a Hermes Agent masterclass covering self-evolving skills, memory, GEPA optimization, and multi-agent setup.
- https://x.com/eng_khairallah1/status/2065764993425907903 - thread/video link about building AI agents with Claude Code and shifting from prompting to reusable loops.
- https://x.com/akshay_pachaar/status/2069118430582866051 - Akshay Pachaar X post/video pointing to Boris Cherny's "loop engineering" framing: stop one-off prompting agents and design repeatable agent loops instead.
- https://x.com/0xCodez/status/2064374643729773029 - thread on loop engineering: a roadmap from manual prompting to reusable agent loops and loop-designer workflows.

### Multi-agent orchestration & operational design

- https://www.augmentcode.com/guides/agentic-design-patterns - agentic design patterns catalog: workflows vs agents, selection criteria, anti-patterns, and framework implementations across multiple taxonomies (Andrew Ng, Anthropic, community).
- https://kenhuangus.substack.com/p/claude-fable-5-what-changed-and-how - Ken Huang article on Claude Fable 5 changes: less prescriptive prompting, effort as the main cost/latency dial, verifier subagents, file-based memory, and building loops around the model.
- https://kenhuangus.substack.com/p/claude-fable-5-part-2-loop-engineering - Ken Huang article on loop engineering with Claude Fable 5: trigger-executor-grader-memory-stop-rule loops, cost routing across models, and the "maker is never the grader" rule.
- https://openai.com/index/open-source-codex-orchestration-symphony/ - OpenAI article introducing Symphony, an open-source spec for orchestrating Codex agents from issue trackers such as Linear.
- https://steve-yegge.medium.com/welcome-to-gas-town-4f25ee16dd04 - Steve Yegge essay about a wild multi-agent orchestration idea and tooling.
- https://steve-yegge.medium.com/software-survival-3-0-97a2a6255f7b - Steve Yegge essay with an interesting formula for software survival odds, plus a useful UX idea for agent tools:
  - "What I did was make their hallucinations real, over and over, by implementing whatever I saw the agents trying to do with Beads, until nearly every guess by an agent is now correct."
- https://cognition.com/blog/making-fable-cheaper-than-opus - Cognition’s Devin Fusion evaluation: a higher-priced lead model can cost less overall when it delegates early with spec-quality briefs, trusts a cheaper sidekick to implement/test, and reviews diffs rather than redoing the work; the advantage disappears on short or serial debugging tasks that cannot be decomposed.

### Agent environments & experiments

- https://www.reddit.com/r/programming/comments/1ivmgf2/i_made_an_mmorpg_playable_with_an_api_use_any/ - Artifacts MMO: a developer-focused MMORPG where agents or custom programs can play through an HTTP API, including combat, gathering, crafting, and trading.

## RAG / architecture

- https://sumantthakur.substack.com/p/rag-vs-graphrag-vs-vectorless-rag - article on retrieval as an architecture decision: RAG, GraphRAG, and vectorless RAG in production systems.
- https://sumantthakur.substack.com/p/you-need-an-ai-gateway-dont-pick - article on choosing an AI gateway to handle multi-agent rate limits, routing, observability, and provider tradeoffs.

## Security

- https://github.com/slowmist/openclaw-security-practice-guide (last update 04/2026) - security practice guide for OpenClaw / AI assistant workflows.

## Model comparison / playgrounds

- https://artificialanalysis.ai/ - very thorough model comparison across many properties.
- https://openrouter.ai/models?fmt=cards&order=most-popular&categories=programming - most popular programming models with details.
- https://openrouter.ai/rankings - model usage rankings with graphs.
- https://openrouter.ai/chat?room=orc-1769070174-VAhvadxXn6nHuyXe6UAT - record from a multi-model chat room for comparing models on the same prompt.
  - For Elixir, MiniMax M2.1 looks slightly better; for Kotlin, GLM 4.7 looks better, though this is based on one example.
  - MiMo-V2-Flash was not great for Elixir, but looked decent for Kotlin.
  - Interesting observation: the amount of reasoning flips dramatically between models. For Elixir, MiniMax reasons like crazy while GLM reasons much less, though still a lot. For Kotlin, GLM reasons much more.

## Misc / review later

- https://x.com/GergelyOrosz/status/2059688730659524730 - Gergely Orosz thread/video notes on OpenCode creator Dax's skepticism about AI productivity hype.
- https://substack.com/chat/7722979/post/ca032f10-9efd-457b-8aa3-6182caba8212 - Substack chat post titled "Opinion AI in Emerging AI"; saved for later review.
- https://x.com/flavioAd/status/2019474660866290061 - X thread to review.
- https://x.com/KarelDoostrlnck/status/2019477361557926281 - X thread to review.
- https://cajundiscordian.medium.com/is-lamda-sentient-an-interview-ea64d916d917 - LaMDA sentience interview article.
- https://www.decodingai.com/p/agentic-ai-engineering-guide-6-mistakes - guide to common mistakes in agentic AI engineering and how to avoid them.
- https://x.com/TheAhmadOsman/status/2057590224729911346 - link to "LLMs 101: A Practical Guide (2026 Edition)" explaining tokens, transformers, attention, KV cache, and LLM runtime basics.
