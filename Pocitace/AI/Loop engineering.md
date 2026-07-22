# Loop engineering

Loop engineering is the practice of designing systems that prompt, steer, verify, and resume agents, instead of manually prompting an agent turn by turn.

The useful shift is not "better prompts". It is moving up one level of abstraction:

- prompt engineering: what words do I give the model?
- context engineering: what information does the model see?
- harness engineering: what tools, permissions, checks, state, and recovery behavior surround one run?
- loop engineering: how does that harness discover work, delegate it, verify it, persist state, and run again?

The central warning: loops make generation cheap, but judgment remains scarce. A loop should execute. It should not silently decide everything.

## 1. TL;DR / working definition

A loop is a repeatable agent system that:

1. discovers work worth doing,
2. hands a bounded unit to an executor,
3. verifies the result with evidence,
4. persists state outside the conversation,
5. schedules or triggers the next turn.

A loop is not just:

- a long prompt,
- a script that runs once,
- an agent working in the same chat for a long time,
- a cron job containing a wall of instructions,
- an agent that writes code and declares its own work done.

The most compact definition:

> Loop engineering is replacing yourself as the person who prompts the agent by designing the system that prompts, checks, remembers, and re-prompts agents.

The most important safety rule:

> A loop's ceiling is set by the generator. Its floor is set by the evaluator.

## 2. Source map

| Source | Main contribution | How I use it here |
|---|---|---|
| [The Anthropic Playbook PDF](https://drive.google.com/file/d/1qzKI4DKnyHRpXK1J3ATPqwaqLc0iNu-M/view) | Five moves, six parts, failure modes, first-loop checklist | Conceptual backbone |
| [Graph Engineering with Claude](https://x.com/0xRafy/status/2079542513317118268) | 11-step roadmap from loops toward graph-structured agent architecture with Claude | Pointer to compare graph orchestration vocabulary against loop/harness framing |
| [Addy Osmani: Loop Engineering](https://addyosmani.com/blog/loop-engineering/) | Tool-independent shape of loops; automations, worktrees, skills, connectors, subagents, state | Practical vocabulary |
| [Addy Osmani: Agent Harness Engineering](https://addyosmani.com/blog/agent-harness-engineering/) | Agent = model + harness; every mistake becomes a rule | Harness/loop boundary and ratchet discipline |
| [Addy Osmani: The Factory Model](https://addyosmani.com/blog/factory-model/) | Engineers orchestrate systems that write code; specs become leverage | Why loop quality depends on intent quality |
| [Addy Osmani: Comprehension Debt](https://addyosmani.com/blog/comprehension-debt/) | AI output can outpace human understanding; tests are necessary but insufficient | Risk model |
| [Addy Osmani: Intent Debt](https://addyosmani.com/blog/intent-debt/) | The "why" must be externalized or parallel agents repeatedly lose it | Skills/specs/ADRs as durable intent |
| [Addy Osmani: Agentic Engineering](https://addyosmani.com/blog/agentic-engineering/) | Agentic engineering is disciplined delegation, not blind acceptance | Human oversight framing |
| [Addy Osmani: Agentic Autonomy Levels](https://addyosmani.com/blog/agentic-autonomy-levels/) | Assist → managed-by-exception autonomy ladder | Autonomy calibration |
| [Beyond Vibe Coding](https://beyond.addy.ie/) | Context, verification, production workflows, SDLC discipline | Guardrails and workflow maturity |
| [agent-skills](https://github.com/addyosmani/agent-skills/tree/main) | Define → Plan → Build → Verify → Review → Ship skill lifecycle | Skills-by-phase mapping |
| [agent-skills comparison](https://github.com/addyosmani/agent-skills/blob/main/docs/comparison.md) | Comparison with Superpowers and Matt Pocock's skills | Choosing skill styles by task |
| [Superpowers](https://github.com/obra/superpowers) | Autonomous, reasoning-heavy runs; subagents; worktree isolation; strict TDD | Inspiration for long-running loops |
| [Matt Pocock's skills](https://github.com/mattpocock/skills) | Pragmatic daily toolkit; grilling requirements; TDD; pre-commit guardrails | Inspiration for personal workflow loops |

Some links in `Resources.md` are pointers rather than fully reviewed primary sources. Treat this note as a working synthesis, not settled doctrine.

## 3. Concept stack: prompt → context → harness → loop

### Prompt engineering

Prompt engineering asks: what instruction do I give the model now?

It is local to one interaction. It matters, but it is too small a frame for agentic work.

### Context engineering

Context engineering asks: what information should be available to the model at this moment?

Relevant context may include:

- source files,
- specs,
- architecture decisions,
- failing logs,
- tests,
- issue history,
- examples,
- style rules,
- constraints,
- prior attempts.

The core skill is not dumping everything into context. It is assembling the right packet for the job.

### Harness engineering

Harness engineering asks: what system surrounds one agent run?

The harness includes:

- instructions and rules,
- tools and connectors,
- filesystem and sandbox,
- permission boundaries,
- test commands,
- hooks,
- observers,
- recovery paths,
- subagent handoffs,
- cost and latency visibility.

The important formula from harness engineering is:

> Agent = model + harness.

If the agent makes a repeated mistake, the question is not only "which model should I use?" It is also "which harness constraint, check, example, or tool would prevent this next time?"

### Loop engineering

Loop engineering asks: how do agent runs feed into future agent runs?

A loop is a harness plus recurrence, discovery, delegation, verification, durable state, and scheduling. It is the factory layer: the system that organizes agent work.

## 4. Anatomy of a loop

The PDF's five moves are the cleanest minimal model.

### 4.1 Discovery

Discovery decides what work is worth doing this turn.

Inputs might be:

- task tracker items,
- failing CI,
- stale pull requests,
- recent commits,
- incident alerts,
- TODOs,
- inbox notes,
- resource lists,
- recurring maintenance checks.

Discovery quality sets the ceiling for the whole loop. A loop that discovers low-value work will perform the other moves beautifully in service of the wrong thing.

### 4.2 Handoff

Handoff cuts work into bounded units and assigns them to executors.

Good handoff includes:

- one clear task,
- acceptance criteria,
- relevant context,
- allowed and forbidden actions,
- expected artifact,
- isolation boundary,
- escalation rule.

The cleaner the handoff, the easier verification and merging become.

### 4.3 Verification

Verification checks whether the output is actually right.

It should use evidence, not vibes:

- tests,
- builds,
- linters,
- type checks,
- logs,
- screenshots,
- browser traces,
- reproduction steps,
- diff review,
- acceptance-criteria mapping,
- source citations,
- security or performance checks when relevant.

Verification is the easiest step to fake. A loop that never says "no" is probably not verifying.

### 4.4 Persistence

Persistence writes state outside the current model context.

Durable state can live in:

- a markdown file,
- a task tracker,
- an issue comment,
- a handoff document,
- an ADR,
- a branch description,
- a structured state file,
- an orchestration board.

The key distinction:

- context is what the model sees this round,
- memory/state is what survives after the context window disappears.

The agent forgets. The repo, notes, and task system do not.

### 4.5 Scheduling

Scheduling decides when another turn happens.

Scheduling can be:

- manual trigger,
- timer,
- CI failure,
- issue event,
- pull request event,
- inbox arrival,
- daily/weekly review,
- explicit goal loop that continues until a stop condition holds.

Without scheduling, the system may still be useful, but it is a one-shot workflow rather than a loop.

## 5. Six parts: what a loop is built from

The five moves are behaviors. The six parts are implementation primitives. They should be kept tool-agnostic.

| Part | Job | Mostly supports |
|---|---|---|
| Automations / triggers | Start a loop from time or events | Scheduling |
| Skills / rules | Codify reusable project knowledge and procedure | Discovery, handoff, verification |
| Isolation | Keep parallel work from colliding | Handoff |
| Connectors | Let the loop see and act outside the repo | Discovery, persistence |
| Subagents / evaluators | Separate maker from checker | Verification |
| Memory / state | Persist progress across turns | Persistence, discovery |

Concrete tools change. The shape does not.

Examples:

- automations may be cron, CI, scheduler jobs, local reminders, cloud workflows, or agent-native automation;
- isolation may be git worktrees, separate branches, containers, sandboxes, or cloud workspaces;
- memory may be beads, Linear, GitHub issues, markdown, a database, or a dedicated agent-state file;
- connectors may be MCP servers, APIs, CLIs, browser automation, or first-party integrations;
- skills may be `SKILL.md`, command files, prompts, playbooks, checklists, or project rules.

## 6. The maker must not be the grader

The generator is biased by its own reasoning. It knows why it made the change and tends to see that rationale instead of the artifact.

A verifier should therefore be structurally separate when stakes are non-trivial.

Good verifier behavior:

- inspect artifacts, not the generator's self-justification;
- start skeptical;
- map evidence to acceptance criteria;
- run or inspect checks directly where possible;
- identify missing evidence;
- say "no" with reasons;
- escalate uncertainty instead of smoothing it over.

Maker/checker separation can be implemented many ways:

- separate subagent,
- separate model,
- separate human review,
- fresh context review,
- automated checks plus human inspection,
- adversarial review skill.

The principle matters more than the mechanism.

## 7. Failure modes

Each major failure mode corresponds to one missing move.

### 7.1 Nodding loop: verification skipped

The same agent writes the work and declares it done.

Symptoms:

- the loop has never rejected its own output;
- every run ends with confident success language;
- evidence is vague or absent;
- tests are cited but not actually run;
- the review repeats the author's rationale.

Fix: add an independent evaluator with permission to block completion.

### 7.2 Manual loop: scheduling skipped

The workflow only runs when the human remembers.

Symptoms:

- the last run was the day it was demoed;
- setup is impressive but dormant;
- no event or cadence starts it.

Fix: add a trigger, cadence, or explicit manual review ritual.

### 7.3 Blind loop: discovery skipped

The loop executes work, but the human still discovers and prioritizes everything.

Symptoms:

- morning still starts with manually deciding what agents should do;
- the loop saves typing but not attention;
- it cannot surface opportunities or risks.

Fix: teach discovery into a reusable skill or query over a durable task/source system.

### 7.4 Tangled loop: handoff/isolation skipped

Parallel workers mutate the same workspace or overlapping scope.

Symptoms:

- conflicts appear only under parallelism;
- agents overwrite or duplicate each other;
- merge/review costs erase the speedup.

Fix: one bounded task per isolated workspace, with explicit ownership.

### 7.5 Amnesiac loop: persistence skipped

State lives in chat and disappears.

Symptoms:

- each turn rediscovers previous decisions;
- follow-up agents lack the prior state;
- old findings are repeated;
- "done" is not recorded anywhere durable.

Fix: write status, decisions, evidence, and next actions to persistent memory.

### 7.6 Impressive-but-useless loop: judgment skipped

The loop produces artifacts, but not decisions you trust.

Symptoms:

- output volume rises but review burden rises too;
- the loop creates work about work;
- artifacts are polished but not actionable;
- humans rubber-stamp because stopping the loop feels expensive.

Fix: define the decision the loop is meant to improve, then require an evidence packet for that decision.

## 8. Costs and risks

Loops fail quietly. The dangerous costs often do not announce themselves during the run.

| Risk | Meaning | Guardrail |
|---|---|---|
| Verification debt | Output accumulates faster than correctness evidence | Independent evaluator + required evidence packet |
| Comprehension debt / rot | Code or docs change faster than human understanding | Regular sample review; explain changes in your own words |
| Intent debt | The "why" is not externalized for future humans/agents | Specs, ADRs, skills, handoffs, rationale notes |
| Cognitive surrender | Human stops having an opinion | Keep at least one real human checkpoint |
| Token/cost blowout | Retries and helpers spend silently | Per-run cap, daily cap, retry cap, escalation rule |
| Orchestration tax | Coordination costs exceed output value | Smaller tasks, fewer agents, clearer handoffs |

Tests are necessary but not sufficient. They check what someone thought to specify. They do not prove that the change preserves unstated user expectations, architectural intent, or load-bearing behavior.

Specs are necessary but not sufficient. A useful spec narrows the space of possible implementations, but non-trivial implementation still includes many implicit decisions.

Comprehension remains the scarce resource.

## 9. Autonomy calibration

The question is not "can this be automated?" The question is:

> What level of autonomy does this task deserve, and what verification makes that level defensible?

### 9.1 Autonomy levels

| Level | Mode | Human role | Good for |
|---|---|---|---|
| 1 | Assist | Ask, inspect, decide | Exploration, learning, risky unknowns |
| 2 | Supervised action | Approve each material step | Small edits, note updates, local refactors |
| 3 | Scoped delegation | Define task; review artifact | Bounded implementation, research, docs |
| 4 | Goal-driven loop | Define stop condition; review evidence | Test-fix loops, migrations, cleanup |
| 5 | Parallel delegation | Assign isolated tasks; merge results | Independent modules, research fan-out |
| 6 | Managed-by-exception | Loop discovers, delegates, verifies, escalates | Mature, low-risk, well-instrumented workflows |

### 9.2 Readiness questions

Before increasing autonomy, ask:

- How quickly will I know it is wrong?
- How cleanly can I undo it?
- What evidence proves it is right?
- What evidence proves it should stop?
- What is the cost/time/retry budget?
- Which actions are forbidden?
- Where does state live?
- Who or what can say "no"?
- Where does uncertainty escalate?
- What is the blast radius?

## 10. Applying this to my workflow

This section should stay tool-agnostic. Specific tools are examples of roles in the loop, not the loop itself.

### 10.1 Current workflow primitives

| Loop concept | Workflow primitive | Tool-agnostic role |
|---|---|---|
| Durable state | beads, notes, handoff docs, issues | Persistent task/memory layer |
| Discovery | ready-task queries, CI failures, inbox notes, resource lists | Work source |
| Handoff | one bead/story/spec per run | Bounded delegation unit |
| Isolation | worktrees, branches, sandboxes, cloud workspaces | Collision prevention |
| Skills | local skills, project rules, playbooks | Reusable process memory |
| Verification | tests, lint, builds, review skills, evaluator agents | Evidence and blocking |
| Connectors | CLIs, APIs, MCP, browser, task tracker integration | External visibility/action |
| Human checkpoint | review before close/commit/merge/publish | Judgment gate |

Useful local examples without binding the model to any one tool:

- beads can act as canonical task memory;
- skills can encode recurring workflows;
- subagents can separate research, planning, execution, and verification;
- worktrees/sandboxes can isolate parallel agents;
- handoff docs can preserve context between sessions;
- verification skills can enforce evidence before completion.

### 10.2 Candidate first loops

Start with low blast radius. Use loops to learn loop design before trusting them with high-impact changes.

#### Resource distillation loop

- Trigger: manual or weekly.
- Discovery: read resource list and new links.
- Handoff: summarize one resource or cluster.
- Verification: source-grounded summary, uncertainty flagged.
- Persistence: update note or propose patch.
- Human checkpoint: approve before publishing into permanent notes.

Why it is good first: valuable, low risk, easy to inspect.

#### Morning task triage loop

- Trigger: morning/manual.
- Discovery: ready tasks, blockers, recent handoffs, repo state.
- Handoff: produce a ranked work brief.
- Verification: check each recommendation against task status and dependencies.
- Persistence: write short daily brief.
- Human checkpoint: human chooses the task.

Why it is good first: automates discovery without automating judgment.

#### Closeout verification loop

- Trigger: before closing a task.
- Discovery: task acceptance criteria, diff, tests, docs.
- Handoff: evaluator receives artifacts only.
- Verification: map evidence to acceptance criteria.
- Persistence: evidence packet in task/handoff.
- Human checkpoint: close only after evidence is credible.

Why it is good first: reduces false "done".

#### Parallel research loop

- Trigger: broad task touching several areas.
- Discovery: identify independent research questions.
- Handoff: one read-only subagent per area/source.
- Verification: compare summaries, cite files/URLs, flag conflicts.
- Persistence: compact plan/handoff note.
- Human checkpoint: approve implementation plan before edits.

Why it is useful: gains parallelism with little write risk.

#### Implementation loop

- Trigger: selected task with clear scope.
- Discovery: task/spec plus relevant repo context.
- Handoff: one isolated workspace per task.
- Verification: tests/build/review by separate checker.
- Persistence: commits, task updates, handoff notes, evidence.
- Human checkpoint: review before merge/release.

Why it is later: higher blast radius; needs mature verification and isolation.

### 10.3 Skills by loop phase

Think of skills as reusable procedures for a phase of the loop. They should encode process, exit criteria, and common failure guards, not just advice.

| Loop phase | Useful skill types | Concrete inspirations |
|---|---|---|
| Discovery / definition | requirement interview, idea refinement, source discovery, task triage | `interview-me`, `idea-refine`, brainstorming/grill-me, ready-task triage |
| Specification | spec-driven development, PRD writing, ADR drafting, source-grounded research | `spec-driven-development`, `documentation-and-adrs`, OpenSpec-style proposal, PRD-writing skill |
| Planning / handoff | task breakdown, dependency ordering, acceptance criteria, execution planning | `planning-and-task-breakdown`, writing-plans, PRD-to-beads/task-creation skill |
| Context packaging | context engineering, source-driven development, retrieval discipline | `context-engineering`, `source-driven-development` |
| Implementation | incremental implementation, TDD, API/interface design, UI engineering, migration | `incremental-implementation`, `test-driven-development`, `api-and-interface-design`, `frontend-ui-engineering`, implementation skills |
| Debugging | reproduce-localize-reduce-fix-guard, systematic incident triage | `debugging-and-error-recovery`, systematic-debugging |
| Verification | test strategy, browser/runtime testing, doubt-driven review, evidence packet | `browser-testing-with-devtools`, `doubt-driven-development`, verification-before-completion, validate/checker agents |
| Review | code review, simplification, security, performance | `code-review-and-quality`, `code-simplification`, `security-and-hardening`, `performance-optimization`, receiving/requesting review |
| Persistence | git/versioning, ADRs, handoffs, task updates, memory/state files | `git-workflow-and-versioning`, `documentation-and-adrs`, handoff docs, beads updates |
| Shipping | CI/CD, launch, rollout, rollback, observability | `ci-cd-and-automation`, `shipping-and-launch`, `observability-and-instrumentation` |
| Orchestration | meta-skill routing, subagent dispatch, review fan-out, worktree isolation | `using-agent-skills`, Superpowers-style subagent isolation, subagent-driven-development |

### 10.4 What to borrow from the three skill ecosystems

From `agent-skills`:

- lifecycle phases: Define → Plan → Build → Verify → Review → Ship;
- human checkpoint at each phase;
- anti-rationalization guards;
- red flags;
- review personas;
- broad coverage beyond coding: security, performance, CI/CD, observability, launch.

From Superpowers:

- more upfront reasoning for uncertain work;
- strict TDD discipline;
- subagent-driven execution;
- two-stage review;
- worktree isolation for parallelism;
- better fit for long autonomous handoffs.

From Matt Pocock's skills:

- low-ceremony daily commands;
- requirement grilling before coding;
- strict red/green/refactor loop;
- bug diagnosis and pre-commit guardrails;
- practical personal workflow patterns.

Do not stack multiple meta-routers at once. Pick one primary routing philosophy for a session, then borrow individual skills à la carte.

## 11. Loop contract template

Every proposed loop should be written as a contract before it is automated.

| Field | Question |
|---|---|
| Name | What is this loop called? |
| Purpose | What decision or outcome does it improve? |
| Trigger | What starts it? |
| Discovery source | What does it read to find work? |
| Allowed actions | What may it do? |
| Forbidden actions | What must it never do? |
| Handoff unit | What is one bounded task? |
| Isolation | How are parallel workers separated? |
| Context packet | What information does the executor receive? |
| Executor | Who/what performs the work? |
| Verifier | Who/what can reject the work? |
| Evidence required | What proof is needed? |
| State/memory | Where is progress recorded? |
| Stop condition | What means done? |
| Retry/budget limits | How many turns, how much time/cost? |
| Human checkpoint | Where does a human decide? |
| Escalation rule | What happens on uncertainty or failure? |
| Rollback/undo | How can the work be reverted? |

Short version:

| Field | Value |
|---|---|
| Reads |  |
| Writes |  |
| Can do |  |
| Cannot do |  |
| Done means |  |
| Evidence |  |
| Stops/escalates when |  |
| Human reviews |  |

## 12. First-loop checklist

Before letting a loop run unattended, answer:

- What does it read on a timer or trigger?
- Where does cross-cycle state live?
- What can say "no" independently?
- Is each parallel worker isolated?
- What is the token/time/retry cap?
- Who stops it if it runs off?
- Where does it pause for human review?
- What evidence is required before accepting output?
- What is the rollback path?
- What did the last failure teach us to add to the harness?

Recommended first loop for my workflow:

1. resource distillation loop, or
2. morning task triage loop, or
3. closeout verification loop.

Avoid starting with an unattended implementation loop. Build the muscles first: discovery, state, evaluator, evidence, checkpoint.

## 13. Operational discipline

### 13.1 The ratchet: every mistake becomes a rule

When an agent makes a mistake, treat it as a design input.

Ask:

- Was context missing?
- Was the instruction ambiguous?
- Was a forbidden action not forbidden?
- Was the check too weak?
- Was the task too large?
- Was state missing?
- Did the verifier see the wrong artifact?
- Was the stop condition vague?

Then add the smallest durable improvement:

- a skill rule,
- a test,
- a hook,
- a checklist item,
- a better task template,
- a sandbox boundary,
- a verifier requirement,
- a handoff field,
- an ADR.

### 13.2 Read a sample, always

Do not try to read everything the loop produces. That defeats the purpose.

Do read a representative sample regularly and explain:

- what changed,
- why it changed,
- what assumptions it relies on,
- what could break,
- what evidence supports it.

If I cannot explain sampled output, my mental model is behind the system.

### 13.3 Cap before shipping

Set caps before unattended execution:

- max turns,
- max wall-clock time,
- max spend,
- max retries,
- max parallel workers,
- max files changed,
- max risk level before escalation.

A loop without caps has delegated spending and blast radius to its own bugs.

### 13.4 Keep one door open

Every important loop should contain at least one real human checkpoint.

The checkpoint is not there because the human must always intervene. It is there so the human remains capable of intervening.

## 14. Glossary

| Term | Meaning |
|---|---|
| Loop | A system that discovers, delegates, verifies, persists, and runs again |
| Harness | The tools, rules, state, checks, and recovery paths around one agent run |
| Skill | Reusable procedure/instruction package with triggers and exit criteria |
| Connector | Integration that lets an agent see or act in an external system |
| Subagent | Separate agent role, often with narrower context or purpose |
| Evaluator | Checker that judges output using evidence |
| Memory/state | Durable information outside the model context |
| Trigger | Event or cadence that starts a loop turn |
| Stop condition | Evidence-backed condition that ends a loop |
| Handoff | Bounded task package passed to an executor |
| Isolation | Workspace boundary that prevents parallel collisions |
| Evidence packet | Tests/logs/diff/screenshots/citations proving or disproving done |
| Verification debt | Accumulated unproven output |
| Comprehension debt | Gap between what exists and what humans understand |
| Intent debt | Missing rationale, goals, constraints, and tradeoffs |
| Cognitive surrender | Loss of human judgment through over-acceptance |
| Orchestration tax | Coordination overhead from too many agents or weak handoffs |

## 15. Open questions / research backlog

- Which task system should be canonical memory for coding loops?
- What is the minimum evidence packet for closing a task?
- Which loops deserve scheduling, and which should stay manual-triggered?
- How much parallelism can I actually review?
- What belongs in skills vs project rules vs ADRs vs handoff docs?
- When should a verifier be a subagent, a different model, a human, or deterministic checks?
- How should cost caps be represented in loop contracts?
- What is the right default human checkpoint before commit, close, merge, or publish?
- Which repeated failures should be turned into new skills?
- How can notes workflows and coding workflows share the same loop vocabulary without becoming tool-bound?

## 16. Personal working maxims

- Design the loop, not just the prompt.
- Keep state out of chat.
- Do not let the maker be the grader.
- A loop that cannot say "no" is not safe.
- A loop that cannot stop is not done.
- A loop that cannot explain its evidence is just producing artifacts.
- Skills pay down intent debt.
- Specs multiply across agents; ambiguity multiplies too.
- Tests are necessary; comprehension is still required.
- Start with low-risk loops before implementation loops.
- Keep the tools replaceable and the loop shape stable.
- Stay the engineer, not just the person who presses go.