# Graph Report - .  (2026-06-30)

## Corpus Check
- 56 files · ~80,302 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 1305 nodes · 3181 edges · 55 communities (51 shown, 4 thin omitted)
- Extraction: 98% EXTRACTED · 2% INFERRED · 0% AMBIGUOUS · INFERRED: 64 edges (avg confidence: 0.82)
- Token cost: 0 input · 179,951 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Native Session Panel (sessions.rs)|Native Session Panel (sessions.rs)]]
- [[_COMMUNITY_CLI Sidecar (agent-sessions-cli)|CLI Sidecar (agent-sessions-cli)]]
- [[_COMMUNITY_Aterm App Chrome (tabssplits)|Aterm App Chrome (tabs/splits)]]
- [[_COMMUNITY_Claude Provider|Claude Provider]]
- [[_COMMUNITY_Terminal Core (termmod.rs)|Terminal Core (term/mod.rs)]]
- [[_COMMUNITY_VS Code Webview UI (main.js)|VS Code Webview UI (main.js)]]
- [[_COMMUNITY_VS Code Extension Entry (extension.ts)|VS Code Extension Entry (extension.ts)]]
- [[_COMMUNITY_Codex Provider|Codex Provider]]
- [[_COMMUNITY_Extension Manifest (package.json)|Extension Manifest (package.json)]]
- [[_COMMUNITY_SessionsView Tree & Groups|SessionsView Tree & Groups]]
- [[_COMMUNITY_Gemini Provider|Gemini Provider]]
- [[_COMMUNITY_Factory Droid Provider|Factory Droid Provider]]
- [[_COMMUNITY_Goose Provider|Goose Provider]]
- [[_COMMUNITY_Qwen Code Provider|Qwen Code Provider]]
- [[_COMMUNITY_OpenCode Provider|OpenCode Provider]]
- [[_COMMUNITY_Extension Session Commands|Extension Session Commands]]
- [[_COMMUNITY_ExportImport Transfer|Export/Import Transfer]]
- [[_COMMUNITY_Terminal Grid Render (render.rs)|Terminal Grid Render (render.rs)]]
- [[_COMMUNITY_Project Docs & CI Concepts|Project Docs & CI Concepts]]
- [[_COMMUNITY_Session Extraction & Preview|Session Extraction & Preview]]
- [[_COMMUNITY_Session Metadata Store|Session Metadata Store]]
- [[_COMMUNITY_Pro License Gate|Pro License Gate]]
- [[_COMMUNITY_Provider Base & Binary Resolution|Provider Base & Binary Resolution]]
- [[_COMMUNITY_Extension LaunchResume Helpers|Extension Launch/Resume Helpers]]
- [[_COMMUNITY_Live Session Detection|Live Session Detection]]
- [[_COMMUNITY_Session Tags & Notes|Session Tags & Notes]]
- [[_COMMUNITY_Native Settings|Native Settings]]
- [[_COMMUNITY_Theme & Palettes|Theme & Palettes]]
- [[_COMMUNITY_Core Session Types|Core Session Types]]
- [[_COMMUNITY_TypeScript Config|TypeScript Config]]
- [[_COMMUNITY_Service Status (statuspage)|Service Status (statuspage)]]
- [[_COMMUNITY_Provider RegistryDetect|Provider Registry/Detect]]
- [[_COMMUNITY_Setting notifyOnIdle|Setting: notifyOnIdle]]
- [[_COMMUNITY_Setting scanProviders|Setting: scanProviders]]
- [[_COMMUNITY_Brand Icon (rasterextension)|Brand Icon (raster/extension)]]
- [[_COMMUNITY_Brand Icon (SVG source)|Brand Icon (SVG source)]]
- [[_COMMUNITY_Setting claudeContextWindow|Setting: claudeContextWindow]]
- [[_COMMUNITY_Setting groupBy|Setting: groupBy]]
- [[_COMMUNITY_Setting notificationLevel|Setting: notificationLevel]]
- [[_COMMUNITY_Setting pollIntervalSec|Setting: pollIntervalSec]]
- [[_COMMUNITY_Setting pro.idleAlertMin|Setting: pro.idleAlertMin]]
- [[_COMMUNITY_Setting refreshSec|Setting: refreshSec]]
- [[_COMMUNITY_Setting tagCatalog|Setting: tagCatalog]]
- [[_COMMUNITY_Setting costAlertDaily|Setting: costAlertDaily]]
- [[_COMMUNITY_Pro API Contract|Pro API Contract]]
- [[_COMMUNITY_Meta-repo Tooling|Meta-repo Tooling]]
- [[_COMMUNITY_Setting cliPath|Setting: cliPath]]
- [[_COMMUNITY_Setting closeOnExit|Setting: closeOnExit]]
- [[_COMMUNITY_Setting fetchStatus|Setting: fetchStatus]]
- [[_COMMUNITY_Setting notifyOnFinish|Setting: notifyOnFinish]]
- [[_COMMUNITY_Setting openInEditor|Setting: openInEditor]]
- [[_COMMUNITY_Aterm Main Entry|Aterm Main Entry]]
- [[_COMMUNITY_Icon Build Script|Icon Build Script]]
- [[_COMMUNITY_VSIX Build Script|VSIX Build Script]]
- [[_COMMUNITY_GitHub Sponsors Funding|GitHub Sponsors Funding]]

## God Nodes (most connected - your core abstractions)
1. `AtermApp` - 45 edges
2. `TermInstance` - 39 edges
3. `SessionPanel` - 38 edges
4. `SessionsView` - 37 edges
5. `AgentSession` - 31 edges
6. `main()` - 30 edges
7. `emit()` - 29 edges
8. `notifyError()` - 28 edges
9. `notifyInfo()` - 24 edges
10. `sessionContextMenu()` - 24 edges

## Surprising Connections (you probably didn't know these)
- `Split open-core (Community vs Pro privado)` --semantically_similar_to--> `Publicación oficial desde agent-sessions-pro`  [INFERRED] [semantically similar]
  HANDOFF.md → agent-sessions/.github/workflows/release.yml
- `agent-sessions read-only por diseño` --conceptually_related_to--> `Sidecar agent-sessions-cli (JSON stdout)`  [INFERRED]
  .claude/skills/revisar-proyecto/SKILL.md → agent-sessions/README.md
- `clippy informativo para vendor agent-sessions` --conceptually_related_to--> `Tres divergencias del vendor agent-sessions`  [INFERRED]
  agent-sessions/aterm/.github/workflows/ci.yml → .claude/skills/revisar-proyecto/SKILL.md
- `aterm-workspace (README)` --conceptually_related_to--> `Meta-repo aterm-workspace (Aterm-labs)`  [INFERRED]
  README.md → HANDOFF.md
- `Split open-core (Community vs Pro privado)` --conceptually_related_to--> `Edición Pro (open-core)`  [INFERRED]
  HANDOFF.md → agent-sessions/README.md

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Pipeline de build/release multiplataforma** — agent_sessions__github_workflows_ci_ci, agent_sessions__github_workflows_release_release, agent_sessions_aterm__github_workflows_release_release, agent_sessions_readme_sidecar_cli [INFERRED 0.75]
- **Modelo open-core Community/Pro** — handoff_open_core_split, handoff_lemon_squeezy_licensing, agent_sessions_readme_pro_edition, agent_sessions__github_workflows_release_marketplace_note [INFERRED 0.75]
- **Descubrimiento de sesiones core→sidecar→UI** — agent_sessions_aterm_docs_providers_roadmap_agentprovider_trait, agent_sessions_readme_sidecar_cli, agent_sessions_readme_webviewview, agent_sessions_media_webview_index_webview_html [INFERRED 0.75]

## Communities (55 total, 4 thin omitted)

### Community 0 - "Native Session Panel (sessions.rs)"
Cohesion: 0.06
Nodes (68): AgentSession, c_card(), c_green(), c_lavender(), c_teal(), completion_label(), config_dir(), count_states() (+60 more)

### Community 1 - "CLI Sidecar (agent-sessions-cli)"
Cohesion: 0.10
Nodes (81): apply_patch(), archive_cmd(), archive_dir(), archive_entries(), archive_restore_cmd(), argv_cmd(), backup(), claude_config_dir() (+73 more)

### Community 2 - "Aterm App Chrome (tabs/splits)"
Cohesion: 0.06
Nodes (47): AtermApp, default_shell(), home_dir(), install_fonts(), label_w(), open_url(), Color32, Context (+39 more)

### Community 3 - "Claude Provider"
Cohesion: 0.09
Nodes (45): truncate_title(), build_session(), claude_turn(), ClaudeProvider, count_lines(), deep_scan(), deep_scan_captures_latest_context_tokens(), DeepScan (+37 more)

### Community 4 - "Terminal Core (term/mod.rs)"
Cohesion: 0.06
Nodes (33): bare_www_gets_https_scheme(), chars(), child_exit_code_is_observed(), child_output_reaches_the_grid(), EventProxy, finds_url_under_column_and_trims_punctuation(), Modes, Context (+25 more)

### Community 5 - "VS Code Webview UI (main.js)"
Cohesion: 0.07
Nodes (51): actionBtn(), applyFilter(), barRow(), bucketByProject(), bucketHeader(), buildTagMenu(), card(), cardList() (+43 more)

### Community 6 - "VS Code Extension Entry (extension.ts)"
Cohesion: 0.04
Nodes (57): activate(), ArchivedEntry, buildHandoff(), cliPath(), collectScriptsAt(), collectSlashCommands(), COLOR_PALETTE, COMPACT_PROVIDERS (+49 more)

### Community 7 - "Codex Provider"
Cohesion: 0.12
Nodes (30): archived_sessions_are_excluded(), build_session(), codex_turn(), CodexProvider, collect_rollouts(), delete_archives_preserving_date_subpath(), latest_context_tokens(), lists_rollouts_with_meta_and_prompt() (+22 more)

### Community 8 - "Extension Manifest (package.json)"
Cohesion: 0.04
Nodes (44): activationEvents, author, bugs, url, categories, contributes, commands, keybindings (+36 more)

### Community 9 - "SessionsView Tree & Groups"
Cohesion: 0.10
Nodes (13): assignToGroup(), createGroup(), crypto(), currentGroupMode(), editProjectIcon(), editSessionIcon(), manageGroups(), notifySession() (+5 more)

### Community 10 - "Gemini Provider"
Cohesion: 0.14
Nodes (24): build_session(), chat_session_id(), delete_unlinks_the_chat_file(), gemini_turn(), GeminiProvider, ignores_non_session_files(), lists_sessions_with_registry_cwd(), load_project_registry() (+16 more)

### Community 11 - "Factory Droid Provider"
Cohesion: 0.14
Nodes (21): build_session(), delete_unlinks_chat_and_settings(), factory_turn(), FactoryProvider, ignores_settings_sidecar(), lists_session_with_cwd_and_first_prompt_title(), mtime_secs(), preview_extracts_message_turns_skips_session_start() (+13 more)

### Community 12 - "Goose Provider"
Cohesion: 0.13
Nodes (20): CachedList, cap_for_preview(), DbStamp, GooseProvider, GooseRow, parse_session_list(), parses_session_list_json(), resume_argv_shape() (+12 more)

### Community 13 - "Qwen Code Provider"
Cohesion: 0.14
Nodes (20): build_session(), delete_unlinks_chat_and_runtime(), ignores_runtime_sidecar(), lists_sessions_with_cwd_branch_and_title(), mtime_secs(), preview_extracts_user_and_assistant_skips_system(), qwen_turn(), QwenProvider (+12 more)

### Community 14 - "OpenCode Provider"
Cohesion: 0.12
Nodes (21): hide_console(), CachedList, DbStamp, OpencodeProvider, OpencodeSessionRow, parse_session_list(), parses_session_list_json(), resume_argv_shape() (+13 more)

### Community 15 - "Extension Session Commands"
Cohesion: 0.15
Nodes (32): addProjectToWorkspace(), afterDelete(), backupCatalog(), clearMetadata(), compactSession(), configureMcp(), continueAsOtherAgent(), conversationMarkdown() (+24 more)

### Community 16 - "Export/Import Transfer"
Cohesion: 0.19
Nodes (30): add_dir_recursive(), add_file(), chrono_free_timestamp(), dummy_session(), export_import_roundtrip_preserves_payload_and_metadata(), export_sessions(), export_with_nothing_eligible_writes_no_zip(), exported_manifest_is_snake_case_on_disk() (+22 more)

### Community 17 - "Terminal Grid Render (render.rs)"
Cohesion: 0.11
Nodes (28): bright(), CellMetrics, color32(), dim(), draw(), draw_cursor(), named_default(), palette() (+20 more)

### Community 18 - "Project Docs & CI Concepts"
Cohesion: 0.08
Nodes (29): Comando revisar-proyecto, agent-sessions read-only por diseño, Skill revisar-proyecto, Tres divergencias del vendor agent-sessions, Agent Sessions CI workflow, Publicación oficial desde agent-sessions-pro, Agent Sessions Release workflow (Community .vsix), aterm core CI workflow (+21 more)

### Community 19 - "Session Extraction & Preview"
Cohesion: 0.19
Nodes (25): cap_text(), claude_like_extractor(), event(), extract_tag(), floor_char_boundary(), fts_text(), fts_text_concatenates_and_caps(), fts_text_none_when_nothing_extractable() (+17 more)

### Community 20 - "Session Metadata Store"
Cohesion: 0.15
Nodes (15): key(), MetadataStore, parse_tags(), persisted_roundtrip_and_byte_stable(), roundtrips_through_disk(), FnOnce, HashMap, Option (+7 more)

### Community 21 - "Pro License Gate"
Cohesion: 0.20
Nodes (5): LicenseService, lsPost(), openBuy(), productMatches(), ProStatus

### Community 22 - "Provider Base & Binary Resolution"
Cohesion: 0.17
Nodes (16): dummy_session(), file_cache_failed_build_is_not_cached(), file_cache_hits_on_same_mtime_and_rebuilds_on_change(), FileScanCache, find_binary(), resolve_binary(), FnOnce, HashMap (+8 more)

### Community 23 - "Extension Launch/Resume Helpers"
Cohesion: 0.15
Nodes (16): archivedToSession(), clearProjectMetadata(), discoverScripts(), displayPath(), newSession(), openManySessions(), openTerminalAt(), patchProject() (+8 more)

### Community 24 - "Live Session Detection"
Cohesion: 0.18
Nodes (14): claude_live_sessions(), ClaudeRegistryEntry, dead_pid_is_not_live(), own_pid_is_live(), parse_stat_starttime(), pid_alive(), proc_start_matches(), proc_start_mismatch_marks_entry_stale() (+6 more)

### Community 25 - "Session Tags & Notes"
Cohesion: 0.26
Nodes (15): dedupeTags(), deleteSession(), editNotes(), editTags(), editTagsFreeText(), manageTagCatalog(), parseTagInput(), patchMetadata() (+7 more)

### Community 26 - "Native Settings"
Cohesion: 0.21
Nodes (12): get(), load_from_disk(), path(), Default, FnOnce, PathBuf, Result, Self (+4 more)

### Community 27 - "Theme & Palettes"
Cohesion: 0.23
Nodes (13): apply(), current_name(), load_persisted(), pal(), Palette, rgb(), Color32, Context (+5 more)

### Community 28 - "Core Session Types"
Cohesion: 0.29
Nodes (11): AgentProviderInfo, DeleteError, LiveAgentSession, PreviewTurn, ProviderQuota, QuotaWindow, Option, String (+3 more)

### Community 29 - "TypeScript Config"
Cohesion: 0.15
Nodes (12): compilerOptions, esModuleInterop, lib, module, outDir, rootDir, skipLibCheck, sourceMap (+4 more)

### Community 30 - "Service Status (statuspage)"
Cohesion: 0.42
Nodes (6): endpoint(), fetch(), parse(), parses_statuspage_v2_body(), Option, ServiceStatus

### Community 31 - "Provider Registry/Detect"
Cohesion: 0.25
Nodes (6): provider_info(), Box, AgentProvider, binary_in_path(), Send, Sync

### Community 32 - "Setting: notifyOnIdle"
Cohesion: 0.29
Nodes (7): default, description, type, properties, title, configuration, agentSessions.notifyOnIdle

### Community 33 - "Setting: scanProviders"
Cohesion: 0.29
Nodes (7): default, description, items, type, uniqueItems, enum, agentSessions.scanProviders

### Community 34 - "Brand Icon (raster/extension)"
Cohesion: 0.53
Nodes (6): agent-sessions App Icon, Chat Speech Bubble Shape (agent), Agent Sessions Extension Icon (chat bubble + terminal prompt), Purple Gradient Background, Speech Bubble Shape, Terminal Prompt Glyph (chevron + cursor)

### Community 35 - "Brand Icon (SVG source)"
Cohesion: 0.40
Nodes (6): White chat speech bubble (agent session), Terminal chevron prompt '>' (purple), Terminal cursor underscore '_' (purple line), Agent Sessions Brand Icon (SVG source), Vertical purple gradient (#8b6dff to #5b3fd6), Rounded purple gradient square (app tile)

### Community 36 - "Setting: claudeContextWindow"
Cohesion: 0.33
Nodes (6): default, description, enum, enumDescriptions, type, agentSessions.claudeContextWindow

### Community 37 - "Setting: groupBy"
Cohesion: 0.33
Nodes (6): default, description, enum, enumDescriptions, type, agentSessions.groupBy

### Community 38 - "Setting: notificationLevel"
Cohesion: 0.33
Nodes (6): default, description, enum, enumDescriptions, type, agentSessions.notificationLevel

### Community 39 - "Setting: pollIntervalSec"
Cohesion: 0.33
Nodes (6): default, description, maximum, minimum, type, agentSessions.pollIntervalSec

### Community 40 - "Setting: pro.idleAlertMin"
Cohesion: 0.33
Nodes (6): default, description, maximum, minimum, type, agentSessions.pro.idleAlertMin

### Community 41 - "Setting: refreshSec"
Cohesion: 0.33
Nodes (6): default, description, maximum, minimum, type, agentSessions.refreshSec

### Community 42 - "Setting: tagCatalog"
Cohesion: 0.33
Nodes (6): default, description, items, type, type, agentSessions.tagCatalog

### Community 43 - "Setting: costAlertDaily"
Cohesion: 0.40
Nodes (5): default, description, minimum, type, agentSessions.costAlertDaily

### Community 44 - "Pro API Contract"
Cohesion: 0.40
Nodes (4): PreviewTurnLite, ProApi, ProModule, SessionLite

### Community 45 - "Meta-repo Tooling"
Cohesion: 0.50
Nodes (5): Tooling Makefile del meta-repo, Meta-repo aterm-workspace (Aterm-labs), Submódulos y pin de punteros, aterm-workspace (README), make bootstrap

### Community 46 - "Setting: cliPath"
Cohesion: 0.50
Nodes (4): default, description, type, agentSessions.cliPath

### Community 47 - "Setting: closeOnExit"
Cohesion: 0.50
Nodes (4): default, description, type, agentSessions.closeOnExit

### Community 48 - "Setting: fetchStatus"
Cohesion: 0.50
Nodes (4): default, description, type, agentSessions.fetchStatus

### Community 49 - "Setting: notifyOnFinish"
Cohesion: 0.50
Nodes (4): default, description, type, agentSessions.notifyOnFinish

### Community 50 - "Setting: openInEditor"
Cohesion: 0.50
Nodes (4): default, description, type, agentSessions.openInEditor

## Knowledge Gaps
- **150 isolated node(s):** `name`, `displayName`, `description`, `version`, `publisher` (+145 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **4 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AgentProvider` connect `Provider Registry/Detect` to `Native Session Panel (sessions.rs)`, `CLI Sidecar (agent-sessions-cli)`, `Claude Provider`, `Codex Provider`, `Gemini Provider`, `Factory Droid Provider`, `Goose Provider`, `Qwen Code Provider`, `OpenCode Provider`, `Provider Base & Binary Resolution`?**
  _High betweenness centrality (0.134) - this node is a cross-community bridge._
- **Why does `SessionPanel` connect `Native Session Panel (sessions.rs)` to `Aterm App Chrome (tabs/splits)`, `Session Metadata Store`?**
  _High betweenness centrality (0.092) - this node is a cross-community bridge._
- **Why does `AtermApp` connect `Aterm App Chrome (tabs/splits)` to `Native Session Panel (sessions.rs)`?**
  _High betweenness centrality (0.087) - this node is a cross-community bridge._
- **What connects `name`, `displayName`, `description` to the rest of the system?**
  _154 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Native Session Panel (sessions.rs)` be split into smaller, more focused modules?**
  _Cohesion score 0.059120555438670314 - nodes in this community are weakly interconnected._
- **Should `CLI Sidecar (agent-sessions-cli)` be split into smaller, more focused modules?**
  _Cohesion score 0.09958960328317373 - nodes in this community are weakly interconnected._
- **Should `Aterm App Chrome (tabs/splits)` be split into smaller, more focused modules?**
  _Cohesion score 0.06080246913580247 - nodes in this community are weakly interconnected._