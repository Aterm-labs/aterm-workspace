# Roadmap — Paridad del gestor de sesiones en la app nativa Aterm

> **Objetivo de alto nivel:** que la app nativa `aterm/` (terminal Rust) ofrezca
> **toda** la funcionalidad del gestor de sesiones que hoy solo existe en la
> extensión de VS Code, para poder usar Aterm **sin depender de VS Code**. El
> terminal en sí ya está al nivel de Ghostty/Warp en lo esencial; el trabajo
> pendiente es portar el *gestor de agentes*.
>
> Documento creado el 2026-06-30 para continuar en otra sesión. Idioma: español.

## Decisiones ya tomadas (no re-preguntar)

1. **Modelo Pro en nativo: replicar el open-core.** Las features Pro llevan gate
   de licencia y su fuente vive en un repo privado, igual que la extensión.
2. **Primera fase: la feature killer = comparativa paralela con git worktrees.**
3. **Terminal: solo gestor por ahora.** No invertir en bloques de comando /
   paleta / autocompletado / render GPU (Fase 5 del roadmap viejo) todavía. El
   terminal actual (alacritty_terminal 0.25.1) es suficiente.

## Estado de partida (medido el 2026-06-30)

- **App nativa** (`agent-sessions/aterm/crates/aterm/src/`, ~5.400 LoC):
  `sessions.rs` (1.738), `app.rs` (1.720), `term/` (~1.300), + theme/settings/
  persist/service_status. Ya tiene paridad en lo básico (filtros, agrupación
  provider/project/cascade, preview, rename/tags/color, export/import .zip,
  delete con confirmación, move_session, FTS, quota/contexto/status, splits,
  tabs, persistencia de pestañas).
- **Extensión** (`agent-sessions/src/`, ~7.500 LoC): `extension.ts` (4.189,
  Community) + `agent-sessions-pro/pro/index.ts` (3.324, Pro) + `license.ts`
  (375) + `pro-api.d.ts` (99). Es la UI **con más features hoy**.
- **Sidecar CLI** (`agent-sessions-cli/src/main.rs`): el core compartido. Ya
  soporta `metadata-set` con `notes`/`favorite`/`persisted`, `templates-*`,
  `backup`/`restore`, `archive`/`unarchive`/`archive-restore`, `search-content`,
  `serve` (MCP). La app nativa enlaza el crate `agent-sessions` directamente (no
  pasa por el sidecar JSON; eso lo hace solo la extensión).

## Delta a cerrar (lo que la app nativa NO tiene)

### Community — el sidecar/core YA lo soporta, falta solo UI nativa
- Notas + favorito en metadata (`metadata.rs` ya tiene los campos).
- Plantillas de lanzamiento (`templates-get/set/delete`).
- Backup/restore de catálogo (`backup`/`restore`).
- Catálogo de tags; iconos de sesión/proyecto.

### Community — lógica que vive solo en la extensión TS
- Grupos/colecciones manuales (nombre+color+icono, vista `groupBy=group`).
- Comandos del proyecto/usuario (slash-commands de `.claude/commands/**` +
  scripts de package.json/Makefile/justfile/Cargo).
- Multiselección + borrado por fecha (`deleteByDate`).
- Paleta de acciones (`actionsMenu`) / acciones rápidas (`quickActions`).
- Dashboard de estadísticas (KPIs, barras por proveedor, sparkline 30d).
- Niveles de notificación (all/important/errors/none), avisos idle/finish,
  alertas de coste diario.
- `smartLaunch` (agente recomendado), `newSessionMulti` (varios proyectos).

### Pro — ausente por completo en nativo (todo gated)
- 🌟 **Comparativa paralela con worktrees** (`launchParallel` /
  `compareWorktrees` / `cleanupWorktrees`).
- Plantillas (en la extensión son Pro; el core las soporta libremente).
- Perfiles de espacio de trabajo (snapshot de proyectos/alias/colores/grupos).
- Dashboard Pro + export CSV; resumen diario; automatizaciones (watcher idle).
- Exportar conversación a HTML.
- `portSession` / `portProject` (migrar conversación entre proveedores).
- Memory graph (CLAUDE.md + imports + memory dir con `[[links]]`).
- Configurar MCP desde UI.
- Modelo de licencia / gate Pro.

## Arquitectura del split open-core en Rust

Rust compila estático (no hay `require()` dinámico como en TS). Plan:

- Crate **`aterm-pro`** en repo privado `Aterm-labs/aterm-pro`, añadido como
  **dependencia opcional de `aterm` tras un feature flag `pro`** de Cargo
  (path/git presente solo en la build oficial). El workspace actual es
  `members = ["crates/agent-sessions", "crates/agent-sessions-cli", "crates/aterm"]`,
  license MIT (`aterm/Cargo.toml`).
- **`aterm/src/pro_api.rs`**: trait `ProModule` (equivalente a `ProApi`/
  `ProModule` de `pro-api.d.ts`) que el core expone (acceso a sesiones, `resume`,
  `open_tab`, estado, exec de git, notificaciones). Con `--features pro` se
  compila la implementación real de `aterm-pro`; sin la feature, **stubs** que
  muestran «edición Community» + upsell.
- **`aterm/src/license.rs`**: portar `LicenseService` de `license.ts`:
  - Trial 14 días (`TRIAL_DAYS = 14`), arranque del reloj en primer uso.
  - Verificación **Ed25519 offline** con clave pública embebida (CLAUDE.md
    confirma que existe; **conseguir la clave pública del proyecto** —
    `license.ts` la embebe — o generar par nuevo dedicado al nativo).
  - Validación online **Lemon Squeezy License API** (`https://api.lemonsqueezy.com/v1/licenses`,
    acciones `activate`/`validate` con la propia key), cache en
    `~/.config/aterm/license.json`, revalidación cada 12h, grace offline de 14d.
  - `require_pro(feature)` → diálogo egui de upsell con `BUY_URL`. Las URLs de
    checkout están en `license.ts` (Lemon Squeezy).
  - Comandos UI: activar licencia, estado, (debug) cambiar estado de prueba.
- `build.sh` oficial compila `--features pro`; el binario Community sin ella.

## Fases de implementación

### Fase 0 — Andamiaje open-core (prerrequisito de Fase 1)
- Crear repo privado `aterm-pro` + crate; feature flag `pro` en `aterm/Cargo.toml`.
- `pro_api.rs` (trait + stubs Community) y `license.rs` (gate completo).
- Verificar que compila **con y sin** `--features pro`.

### Fase 1 — Comparativa paralela con worktrees (Pro) 🌟 EMPEZAR AQUÍ
Replica de `launchParallel`/`compareWorktrees`/`cleanupWorktrees`. Referencia:
`agent-sessions-pro/pro/index.ts` (función `launchParallel` ~L41 en adelante).
Flujo de la extensión a replicar:
1. Detectar repo git desde el cwd activo; validar que es repo git.
2. Diálogo: elegir N agentes/proveedores + un prompt común.
3. Por agente: `git worktree add -B aterm/<agente>-<id> <worktreePath> HEAD`
   (worktreePath = `<parent>/<repoName>-<id>-<stamp>`), luego
   `open_tab(argv_del_proveedor, cwd = worktreePath)` y **pegar el prompt** tras
   el spawn. En la extensión es `terminal.sendText(prompt)` a los 2.5s; en
   nativo, inyectar los bytes del prompt al PTY (vía `TermInstance`) cuando el
   agente esté listo. **DECISIÓN PENDIENTE:** cómo/ cuándo inyectar (timer vs
   detectar prompt listo).
4. **Comparar**: `git worktree list --porcelain` → vista en el panel con estado/
   diff por worktree.
5. **Limpiar**: `git worktree remove --force <path>`.
6. Gate `require_pro("launchParallel")`.

Cableado base ya disponible: `AtermApp::open_tab(ctx, argv, cwd, key)` en
`app.rs:191` (dedup por `key` de sesión). `TermInstance::spawn(argv, cwd, size, ctx)`.

**Entregable:** `cargo run -p aterm --features pro` lanza N agentes en worktrees
aislados desde un botón del panel; compila también sin la feature (stub).

### Fase 2 — Quick wins del sidecar (Community)
Cablear en UI lo que el core YA soporta:
- Notas + favorito (campos en `metadata.rs`; añadir al editor de sesión de
  `sessions.rs`, donde ya están name/tags/color).
- Plantillas (`templates-get/set/delete`): diálogo guardar/lanzar/gestionar.
- Backup/restore de catálogo (`backup`/`restore`).
- Iconos de sesión/proyecto; catálogo de tags (QuickPick marcable).

### Fase 3 — Paridad Community restante
- Grupos/colecciones manuales → persistir en `~/.config/aterm/groups.json`
  (NO tocar la metadata compartida con la extensión).
- Comandos del proyecto/usuario: descubrir `.claude/commands/**` (namespaced,
  descripción del frontmatter) + scripts de package.json (PM autodetectado)/
  Makefile/justfile/Cargo.
- Multiselección + borrado por fecha.
- Paleta de acciones (todas las acciones agrupadas) / acciones rápidas.
- `smartLaunch`, nueva sesión en varios proyectos.
- Niveles de notificación + avisos idle/finish + alertas de coste.

### Fase 4 — Resto de features Pro (todas con `require_pro`)
- Perfiles de espacio de trabajo (guardar/abrir conjuntos de sesiones).
- Dashboard Pro (egui + export CSV); resumen diario; automatizaciones idle.
- Export conversación a HTML.
- `portSession` / `portProject`.
- Memory graph.
- Configurar MCP desde UI (escribir config o copiar snippet).

### Fase 5 — Pulido y release
- Mantener verde `cargo test --workspace` (hoy 60 + 15).
- Garantizar persistencia **byte-compatible** con la extensión
  (`~/.config/aterm/{session-metadata.json, project-names.json}`) — no romper
  interop.
- `graphify update .`; actualizar `CLAUDE.md` (sección «Estado actual»).
- `build.sh`: empaquetado de binarios Pro (oficial) y Community.

## Gotchas / recordatorios

- **No re-implementar el VT loop**: usar `EventLoop` de alacritty_terminal.
- **`agent-sessions` es read-only por diseño** para sesiones (rutas derivadas
  del HOME). No romper esa propiedad. Sí escribe metadata en
  `~/.config/aterm/**` y al importar.
- **Persistencia compartida con la extensión** debe seguir siendo compatible
  (mismos ficheros JSON). Los grupos/iconos de la extensión viven en
  `globalState` (no compartido) → en nativo van a ficheros propios bajo
  `~/.config/aterm/`.
- Antes de explorar código, usar **graphify** (hay hook que lo exige):
  `graphify query "<pregunta>"`, `graphify explain`, `graphify path`.
- El % de contexto de Claude: el core infla el % para cuentas de 1M (no registra
  la ventana). Mitigado en la extensión con setting `claudeContextWindow`
  (auto/200k/1m) — replicar el setting en nativo si se nota.

## Próximo paso al retomar

Arrancar por la **Fase 0 (andamiaje open-core)** seguida de la **Fase 1
(worktrees paralelos)**. Conseguir/decidir la clave pública Ed25519 y resolver
la decisión pendiente de inyección del prompt al PTY.
