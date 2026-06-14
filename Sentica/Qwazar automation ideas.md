# Qwazar automation ideas

## SentiNel workflow ideas
#### **Daily Qwazar dev digest**  
• Commits today, grouped by author/module/ticket prefix.  
• Open MRs changed today.  
• Failed/successful pipelines.  
• New stage tags/releases.  
• “Notable changes” summary from commit titles.  
• Could run on demand first: “Qwazar digest today”, then later as morning/evening briefing.  
#### **“Who did what today?” command**  
• The corrected version of what we just debugged.  
• Counts all refs, paginates, Prague timezone, normalizes aliases like `ivanB → Ivan Basaraba`.  
• Useful variants:  
	• “today”  
	• “this week”  
	• “since last release tag”  
	• “on master only”  
	• “authored vs committed”  
#### **MR health dashboard**
• Open MRs grouped by:  
	• draft vs ready  
	• age  
	• pipeline status  
	• conflicts / mergeability if available  
	• stale for >N days  
• Great for answering “what needs attention?”  
#### **Pipeline failure triage**
• Find latest failed pipelines on `master` / MR refs.  
• Pull failed jobs and last relevant log chunks.  
• Summarize likely failure reason.  
• This could become very valuable quickly.  
#### **Release/tag watcher**
• Detect new `KB-STAGE-*` tags.  
• Summarize commits included since previous tag.  
• Highlight risky areas/modules touched.  
• Good fit for exact cron or briefing integration.  
#### **Ticket/commit lookup helper**
• Ask: “what happened with KB-3385?”  
• I search commits, branches, MRs, pipelines, issues/work items.  
• Return the timeline: branches → commits → MRs → pipelines → tags.  
#### **Repository intelligence notes**  
  
• Build a local map of Qwazar:  
	• modules/directories  
	• owners inferred from commit history  
	• common ticket prefixes  
	• build/test commands  
	• CI stages/jobs  
• This makes future answers much better and avoids rediscovering structure every time.  
  
I’d implement them as small local scripts under something like:  
  
`/root/.openclaw/workspace/workflows/gitlab/`  
  
Then I can use them from any future session instead of re-writing ad hoc API code every time.


## Report triggers

Best workflow shape

Automatic

• Every weekday morning, run:
  • summary
  • “needs attention first”
  • maybe “closest to merge”
• Deliver to either:
  • your Telegram DM
  • a Discord channel
  • both, if configured as separate scheduled jobs

Manual / on-demand

• Trigger specific modes:
  • summary
  • full
  • stale
  • failed-ci
  • ready
  • author Jakub

Manual trigger options

Option A — natural language, no setup

You can just ask me:

Qwazar MR health summary
Qwazar failed CI MRs
Show stale Qwazar MRs
Qwazar MRs by Jakub

This works today in any channel where I’m allowed to respond, but it goes through the LLM each time. Nice and flexible, less “productized”.

Option B — existing text command wrapper

We could create a small local skill or workflow wrapper so you can run something like:

/skill qwazar-mr-health summary
/skill qwazar-mr-health failed-ci
/skill qwazar-mr-health author Jakub

This is easier than a full plugin, and should work on both Telegram and Discord as text commands if command parsing is enabled.

Downside: UX is a bit clunky.

Option C — proper custom slash command

Best UX:

/mrhealth summary
/mrhealth full
/mrhealth stale
/mrhealth failed-ci
/mrhealth ready
/mrhealth author Jakub

or maybe shorter:

/qmr summary
/qmr failed-ci
/qmr author Jakub

This would require creating a small OpenClaw plugin that registers a runtime command and calls the script.

Do Telegram and Discord support slash commands?

Yes, with caveats.

Telegram

• Supports bot commands like /mrhealth.
• OpenClaw can expose commands through text command parsing.
• Telegram bot menu entries can be configured via channels.telegram.customCommands.
• Usually no server-side setup is needed beyond bot permissions / group visibility.
• In groups, Telegram privacy mode matters: if privacy mode is on, the bot may only receive commands, mentions, and replies. That’s fine for slash commands.

Discord

• Supports native slash commands.
• OpenClaw can register native commands when enabled.
• But Discord requires the bot to have been invited with the applications.commands OAuth scope.
• If the bot was invited without that scope, a server/admin-side re-invite or permission update is needed.
• The bot also needs normal channel permissions: View Channel, Send Messages, Read Message History, etc.

Can I fully set it up from my side?

Depends on the level.

I can fully do from here:

• Create the local script/wrapper.
• Create a reusable skill or plugin.
• Add OpenClaw config for Telegram command menu entries.
• Add a cron job for morning delivery.
• Use existing Discord/Telegram channels if the bot already has permission.

May need client/server-side action:

• Discord: if the bot lacks applications.commands, someone with Discord server/admin access must re-invite/authorize it with that scope.
• Discord: if the bot lacks access to the target channel, channel permissions need adjustment.
• Telegram group: if the bot is not in the group, not allowed, or privacy mode blocks the desired behavior, that needs BotFather/group admin changes.

My recommendation

Start in this order:

1. Cron morning report

  • Fastest value.
  • Example: every weekday 08:30 Prague → send MR health summary to Telegram DM or Discord channel.
2. Natural-language/manual triggers

  • Use the script directly when you ask.
  • No extra infrastructure.
3. Then build /qmr as a real command

  • Once we like the exact UX/output.
  • I’d make the command:/qmr summary
/qmr full
/qmr stale
/qmr failed-ci
/qmr ready

For now, I’d avoid over-investing in native slash command registration until
we’ve run the dashboard for a few days and tuned the buckets. The morning cron +
manual natural-language trigger gives us fast feedback with very little risk.
