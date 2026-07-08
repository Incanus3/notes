# Agent Client Protocol (ACP)

_Last updated: 2026-07-08_

## Purpose of this note

Living report on how ACP works, what it standardizes, and what capabilities it provides to editor/client implementations. Keep this updated as we learn more.

## Short version

ACP (Agent Client Protocol) is a JSON-RPC protocol for connecting an AI coding agent to an editor or other client UI. The client launches or connects to an agent, negotiates protocol version and capabilities, creates/resumes sessions, sends user prompts, receives streaming updates, displays tool calls/diffs/plans/terminal output, mediates permissions, and can expose editor-backed filesystem/terminal capabilities to the agent.

For Augment, Auggie can run as an ACP-compatible agent with `auggie --acp`, so ACP clients like Zed, JetBrains ACP integrations, Neovim plugins, and Emacs wrappers can drive Auggie through the standard protocol. Augment notes ACP mode is still evolving and may not expose every feature from Auggie interactive mode.

## Mental model

ACP sits between:

- **Client**: editor/IDE/UI, e.g. Zed, JetBrains, Neovim, Emacs, or a custom app.
- **Agent**: an AI coding agent, e.g. Auggie in `--acp` mode.
- **Optional MCP servers**: external tool/data providers the client can ask the agent to connect to.

ACP is not MCP. MCP exposes tools/resources to agents. ACP exposes an agent UX contract to editors: sessions, prompts, streaming output, tool-call UI, permissions, diffs, terminals, config selectors, and session history.

## ACP vs OpenAI-compatible model APIs vs gateways

These live at different layers:

- **OpenAI-compatible model provider API**: an HTTP inference API shaped like OpenAI's APIs, usually `/v1/chat/completions` or `/v1/responses`. The caller sends messages, tool schemas, model settings, and receives model output. It is mostly a model boundary, not an editor/agent UX boundary.
- **Gateway**: a proxy/router in front of one or more model providers. It often exposes an OpenAI-compatible API while adding routing, fallback, retries, caching, observability, budgets, virtual keys, BYOK, or provider abstraction. Examples: OpenRouter, LiteLLM Proxy, Portkey.
- **ACP**: a protocol between an editor/client and an agent process. It standardizes sessions, prompt turns, streaming UI updates, tool-call display, permission prompts, client filesystem/terminal access, diffs, plans, MCP handoff, config selectors, and session history.

Typical stack:

`Editor/client --ACP--> Agent --OpenAI-compatible API--> Model provider or gateway --native/provider API--> Model`

So ACP is not itself an OpenAI-compatible provider and not itself a model gateway. An ACP agent may call a gateway internally to reach models, but the ACP client usually talks to the agent, not directly to the model provider.

Calling something a **gateway** usually means the model/API routing layer. It is the same thing as an OpenAI-compatible provider only when the gateway intentionally exposes an OpenAI-compatible endpoint. Not every OpenAI-compatible endpoint is a gateway: a single model vendor can expose OpenAI-compatible API without routing across providers.

## Transport and message format

ACP uses **JSON-RPC 2.0**. Current stable transport is primarily **stdio**:

- Client launches the agent as a subprocess.
- Client writes JSON-RPC messages to agent `stdin`.
- Agent writes JSON-RPC messages to `stdout`.
- Messages are UTF-8 and newline-delimited.
- Agent must not write non-ACP data to `stdout`.
- `stderr` may be used for logs in the ACP transport spec, though agents may restrict this. Auggie redirects logs in ACP/MCP modes because protocol streams are reserved.

Streamable HTTP is discussed/drafted, but stable v1 docs emphasize stdio.

## Basic lifecycle

1. **Client starts agent**: for Auggie, run `auggie --acp`.
2. **Initialize**: client calls `initialize` with protocol version and client capabilities. Agent responds with agreed version, agent capabilities, metadata, and auth methods.
3. **Authenticate if needed**: client calls `authenticate`; optional `logout` exists if advertised.
4. **Create or restore session**: client calls `session/new`, `session/load`, or `session/resume` with `cwd`, optional roots, and MCP server configs.
5. **Prompt turn**: client calls `session/prompt`; agent streams `session/update` notifications; final response includes a stop reason.
6. **Cancel if needed**: client sends `session/cancel`; agent should stop work and return `stopReason: cancelled`.

## Capability negotiation

Capabilities are exchanged during `initialize`. If a capability is omitted, treat it as unsupported.

### Client capabilities

- `fs.readTextFile`: agent may call `fs/read_text_file`.
- `fs.writeTextFile`: agent may call `fs/write_text_file`.
- `terminal`: agent may call `terminal/*`.
- `session.configOptions.boolean`: client can render boolean session config controls.

### Agent capabilities

- `loadSession`: client can call `session/load`.
- `sessionCapabilities.list`: client can list sessions.
- `sessionCapabilities.delete`: client can delete sessions from history.
- `sessionCapabilities.resume`: client can reconnect without replay.
- `sessionCapabilities.close`: client can close active sessions.
- `sessionCapabilities.additionalDirectories`: session setup can include extra workspace roots.
- `promptCapabilities.image`, `audio`, `embeddedContext`: richer prompt content.
- `mcpCapabilities.http` / `sse`: agent can connect to MCP servers over those transports.
- `auth.logout`: client can call `logout`.
- Custom capabilities can be advertised in `_meta`.

## What ACP gives the client

### Standard agent integration

The client can support any ACP-compatible agent by launching a process and speaking the same JSON-RPC methods. For Auggie, the command is `auggie --acp`.

### Sessions and conversation state

ACP defines session identity and lifecycle via `session/new`, `session/load`, `session/resume`, `session/close`, `session/list`, and `session/delete`. This enables session pickers, restore-on-restart, multi-session UIs, and session history management.

### Streaming assistant output

The agent streams output through `session/update`, especially `agent_message_chunk`, replayed `user_message_chunk`, and message IDs that group chunks into messages.

### Rich prompt content

ACP uses MCP-compatible content blocks. Baseline content includes text and resource links. Optional capabilities allow images, audio, and embedded resources/files, including context the agent may not otherwise access.

### Tool-call UI

Agents report tool execution with `tool_call` and `tool_call_update`. Tool calls include IDs, titles, kinds, statuses, content, locations, and raw input/output. This supports structured timelines, progress UI, icons, raw details, and follow-along navigation.

Tool kinds include `read`, `edit`, `delete`, `move`, `search`, `execute`, `think`, `fetch`, `switch_mode`, and `other`. Statuses include `pending`, `in_progress`, `completed`, and `failed`.

### Permission prompts

Agents can call `session/request_permission` before executing a tool. Clients can present allow/reject choices such as allow once, allow always, reject once, and reject always.

### Diffs and file-change rendering

Tool-call content can include diffs with absolute path, old text, and new text. Clients can render these as reviewable file modifications. ACP paths are absolute and line numbers are 1-based.

### Editor-backed filesystem access

If advertised by the client, agents can call `fs/read_text_file` and `fs/write_text_file`. `fs/read_text_file` can include unsaved editor state, which is a key advantage over direct filesystem reads.

### Terminal execution

If the client advertises `terminal: true`, agents can call `terminal/create`, `terminal/output`, `terminal/wait_for_exit`, `terminal/kill`, and `terminal/release`. Terminals can be embedded in tool calls for live output.

### Agent plans

Agents can send `plan` updates with entries containing content, priority, and status. Clients replace the current plan with each complete update.

### Session config and modes

Preferred API: `configOptions`, `session/set_config_option`, and `config_option_update`. This supports client-rendered selectors/toggles for model, mode, reasoning/thought level, and agent-specific options. Older `modes` / `session/set_mode` exists for compatibility.

### Slash commands

Agents can advertise slash commands via `available_commands_update`; clients can render autocomplete and send commands as ordinary prompt text.

### Usage and cost visibility

Agents may send `usage_update` with current context usage, total context size, and optional cumulative cost.

### MCP server handoff

During session setup, the client can pass MCP server configs. ACP requires stdio MCP support; HTTP/SSE require advertised capabilities. This lets the client remain the MCP configuration surface while the agent connects directly.

### Extensibility

ACP supports `_meta` fields, custom methods prefixed with `_`, and custom capabilities advertised during initialization.

## Auggie-specific notes

- Start ACP mode with `auggie --acp`.
- ACP client config typically uses command `auggie` and args `["--acp"]`.
- Additional Auggie CLI args can select model, workspace root, auth, tools, MCP settings, etc.
- Augment docs list Zed, JetBrains, Neovim, and Emacs examples.
- ACP is still emerging; not all interactive-mode Auggie features are guaranteed in ACP mode.

## Sources

- https://agentclientprotocol.com/protocol/v1/overview.md
- https://agentclientprotocol.com/protocol/v1/initialization.md
- https://agentclientprotocol.com/protocol/v1/session-setup.md
- https://agentclientprotocol.com/protocol/v1/prompt-turn.md
- https://agentclientprotocol.com/protocol/v1/file-system.md
- https://agentclientprotocol.com/protocol/v1/terminals.md
- https://agentclientprotocol.com/protocol/v1/tool-calls.md
- https://agentclientprotocol.com/protocol/v1/content.md
- https://agentclientprotocol.com/get-started/architecture.md
- https://docs.augmentcode.com/cli/acp/agent.md
- https://docs.augmentcode.com/cli/acp/clients.md
- https://www.assistant-ui.com/docs/integrations/gateways
- https://openrouter.ai/blog/insights/openrouter-vs-litellm/

## Open questions / follow-ups

- Track which Auggie interactive-mode features are unavailable or limited in ACP mode.
- Verify how Auggie maps its internal tools and permissions onto ACP permission prompts in practice.
- Compare ACP stdio versus proposed streamable HTTP once the transport stabilizes.
- Test client-specific behavior in Zed, Neovim, JetBrains, and Emacs.
