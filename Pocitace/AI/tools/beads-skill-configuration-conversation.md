# Beads Skill Configuration Conversation

## Initial Question: Are Beads Useful?

**User:** do you think beads are useful?

**Assistant:** I'd need to understand what you mean by "beads" in this context. I can see there's a beads skill available in your workspace, but I don't have enough information about what it does or how you're using it.

*[After reviewing the beads skill documentation]*

Based on what I can see, **beads** is a git-backed issue tracker designed specifically for AI agents working on multi-session tasks. Here's my take on its usefulness:

### When beads are useful:

**Yes, very useful for:**
- **Multi-session work** - Tasks that span days/weeks across multiple conversations
- **Complex dependencies** - When tasks have blockers or need to be done in a specific order
- **Surviving conversation compaction** - When your chat history gets compressed and you need persistent context
- **Team collaboration** - Git-backed so multiple people/agents can sync work
- **Exploratory work** - Research or tasks with fuzzy boundaries

### When beads are NOT useful:

**Use regular task management instead for:**
- Single-session linear tasks
- Simple checklists for immediate work
- Work that will complete within the current conversation

### The key insight:

The decision test is: **"Will I need this context in 2 weeks?"**
- If YES → use beads (`bd`)
- If NO → use ephemeral task management (like the TodoWrite tools I have)

### My assessment:

Beads solve a real problem for AI agents - **memory persistence across sessions**. Without something like beads, when conversations get compacted or you start a new session, context about ongoing work can be lost. Having a git-backed system that survives compaction is genuinely valuable for long-running projects.

**So yes, I think beads are useful** - but specifically for the use case they're designed for (persistent, multi-session work). They're not a replacement for simple task tracking, but a complement to it.

---
## Proactive Usage Discussion

**User:** With this skill installed, would you use them proactively, without me prompting you to do so?

**Assistant:** Looking at the skill configuration and my instructions, **no, I would not use beads proactively** without you prompting me to do so.

Here's why:
### Current limitations:

1. **The skill description is incomplete** - It just says `>` which doesn't give me clear trigger conditions
2. **No automatic activation** - Unlike other skills that have clear triggers (e.g., "ralph-tui-prd" triggers on "create a prd", "write prd for"), the beads skill doesn't specify when I should automatically invoke it
3. **My default task management** - I already have built-in task management tools (`add_tasks`, `update_tasks`, etc.) that I'm instructed to use frequently for planning and tracking work
### What would need to change:

For me to use beads proactively, the skill would need:

1. **Better description** with clear trigger conditions like:
   - "Use when user mentions work spanning multiple sessions"
   - "Use when tasks have complex dependencies"
   - "Use when user says 'track this' or 'remember this for later'"

2. **Integration with my decision-making** - I'd need explicit instructions that say something like:
   - "When starting multi-session work, ALWAYS check `bd ready` first"
   - "At the end of each session, ALWAYS run `bd sync`"
### Current reality:

Right now, I would only use beads if:
- You explicitly ask me to ("use beads for this", "create a bead", "check bd ready")
- I recognize from context that you're already using beads (e.g., you mention bead IDs)

**So the skill is installed but dormant** - it's available when needed, but won't activate automatically. This is probably intentional to avoid me creating beads for simple tasks that don't need persistence.

---
## Making the Skill Proactive

**User:** I'd like you to suggest using them proactively

**Assistant:** I can help you set that up! To make me suggest beads proactively, we need to update the skill's description with clear trigger conditions.

*[Updates the SKILL.md file]*

Perfect! I've updated the beads skill description to include proactive triggers. Here's what changed:

### New proactive behaviors:

I will now **automatically suggest using beads** when:

1. **Multi-session work** - You mention work spanning multiple days or sessions
2. **Dependencies/blockers** - Tasks have dependencies or blockers
3. **Exploratory work** - Research or work with unclear scope
4. **Explicit tracking requests** - You say "track this", "remember this", "come back to this later"
5. **Session start** - I'll run `bd ready` to check for existing unblocked work
6. **Session end** - I'll suggest `bd sync` to persist changes to git

### What this means in practice:

- If you say something like "I need to refactor the auth system over the next few weeks", I'll suggest creating a bead for it
- At the start of our conversations, I'll check if there's existing bead work to continue
- Before we wrap up, I'll remind you to sync beads to git
- If you mention blockers or dependencies, I'll suggest tracking them in beads

The skill is now configured to be proactive rather than passive.

---
## Clarifying Session Start Behavior

**User:** not right now. just to clarify, you said you'll run "bd ready" at each session start. does that mean you'll start working immediately after session start, or just ask me if I want to?

**Assistant:** Good question - let me clarify my intention there.

I should **ask you first**, not just start working immediately. Here's why:

1. **You might have a different priority** - Just because there's unblocked bead work doesn't mean that's what you want to work on right now
2. **Context matters** - You might be starting a conversation for something completely different
3. **Respect your agency** - I shouldn't assume what you want to work on
### Better behavior:

At session start, I should:
1. Run `bd ready` to check for unblocked work
2. **Inform you** what's available: "I see you have 3 unblocked beads: [list]. Would you like to continue with any of these, or work on something else?"
3. **Wait for your direction** before proceeding
### The description could be clearer

The current wording "ALWAYS run `bd ready`" might be too aggressive. It could be interpreted as "silently check and start working" vs "check and inform the user."

Would you like me to refine the description to be more explicit about **checking and asking** rather than **checking and doing**? Something like:

> "At session start, check `bd ready` and inform user of available work, then ask what they'd like to focus on"

---
## Final Configuration

**User:** yeah, this change sounds perfect

**Assistant:** *[Updates SKILL.md with refined description]*

Perfect! Updated. Now the behavior is clearer:
### Session start:
- ✅ Check `bd ready` for available work
- ✅ Inform you what's available
- ✅ **Ask** what you'd like to focus on (not assume)
### Session end:
- ✅ Suggest `bd sync` to persist changes

This gives you control while still making me proactive about surfacing available bead work. The next time we start a conversation, I'll check for beads and present you with options rather than just diving in.

All set! 🎯