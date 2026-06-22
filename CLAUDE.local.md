---
name: aterm-workspace-overview
description: Meta-repo aterm — terminal nativo en Rust + gestor de sesiones de agentes; estructura de submódulos y modelo open-core
metadata:
  type: project
---

`aterm-workspace` (org Aterm-labs) es el **meta-repo** que agrupa los repos del proyecto como **submódulos** y centraliza el tooling (`Makefile`, `README.md`). Idioma de trabajo: **español**. Se trabaja desde aquí para verlo todo a la vez.

Submódulos:
- `aterm/` — core Rust: app nativa (egui/eframe sobre `alacritty_terminal` 0.25.1) + sidecar `agent-sessions-cli` (emite JSON por stdout). Contiene el vendor read-only `agent-sessions` (copia verbatim de `warp_agent_history`).
- `agent-sessions/` — extensión de VS Code (Community); consume `aterm/` anidado como submódulo para compilar el sidecar.
- `agent-sessions-pro/` — módulo Pro (privado, open-core): comparativa paralela con worktrees, plantillas, perfiles de workspace, dashboard Pro, export HTML, automatizaciones.
- `aterm-web/` — landing (Vite + Vue).

**Razón de ser**: tercera vía tras `multi-claude` (Python/Textual), el fork de Terax (Tauri) y el fork de Warp (Rust). Nace para tener algo propio, mínimo y 100% editable **sin deuda de rebase** — en vez de forkear un terminal, embebe un emulador como librería y le añade el panel de sesiones.

**Open-core**: el source de las features Pro **no** vive en el repo público; está en `agent-sessions-pro`. El contrato está en `src/pro-api.d.ts` (`ProApi`/`ProModule`); `extension.ts` carga dinámicamente `require("./pro")` y degrada a «edición Community» si falta. Gate de licencia en `vscode-extension/src/license.ts` (Ed25519 offline + Lemon Squeezy License API).

**Gotchas clave**:
- `agent-sessions` es read-only por diseño (los providers derivan rutas del `$HOME`, nunca aceptan paths del caller) — mantener esa propiedad al sincronizar con upstream.
- Al re-copiar el vendor desde `../warp/crates/warp_agent_history/src/`, re-aplicar 3 divergencias: quitar `pub mod service_status;` de `lib.rs`; declarar `windows-sys` como dep `[target.'cfg(windows)'.dependencies]`; conservar el campo `SessionMetadata::persisted` en `metadata.rs`.
- La salud de servicios vive en `aterm/src/service_status.rs` (NO el vendor) y usa `curl` a las statuspage v2 para evitar la dep de reqwest.
- `cwd` vivo de la shell vía `/proc/<pid>/cwd` (solo Linux).

Comandos: `cargo run -p aterm`, `cargo check`, `cargo test --workspace` (60 + 15 tests), `cargo build --release`. Para revisión integral usar la skill `revisar-proyecto`.
