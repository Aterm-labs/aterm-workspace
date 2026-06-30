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

### Fase 0 — Andamiaje open-core (prerrequisito de Fase 1) ✅ HECHA (2026-06-30)
- ✅ Crate `aterm-pro-api` (público, miembro): contrato `ProHost`/`ProModule`
  (equivalente Rust de `pro-api.d.ts`).
- ✅ Crate `aterm-pro` (privado, dep **opcional** tras `--features pro`, **NO**
  miembro → ausente en Community). El repo privado `Aterm-labs/aterm-pro` queda
  pendiente de crear; hoy vive como path local `crates/aterm-pro`.
- ✅ `aterm/src/pro.rs` (selector `module()` real/stub + `impl ProHost`) y
  `aterm/src/license.rs` (gate completo).
- ✅ Compila/clippy/test **con y sin** `--features pro`; el binario Community no
  enlaza `aterm-pro` (verificado con `cargo tree`).
- ⚠️ **Ed25519 NO se implementó**: al portar `license.ts` se comprobó que la
  extensión **no usa** verificación Ed25519 — es online-first con Lemon Squeezy
  (`activate`/`validate`) + cache con grace offline de 14 días. El nativo
  replica ese modelo exacto (misma API, mismas BUY URLs, `~/.config/aterm/
  license.json`). Añadir Ed25519 divergiría del producto sin un emisor que firme
  licencias; si se quiere activación 100% offline, sería trabajo nuevo a decidir.

### Fase 1 — Comparativa paralela con worktrees (Pro) 🌟 ✅ HECHA (2026-06-30)
Implementada en `crates/aterm-pro/src/lib.rs` (`ProImpl`):
- `launch_parallel`: diálogo egui (elegir agentes + prompt) → un
  `git worktree add -B agents/<id>-<stamp> <parent>/<repo>-<id>-<stamp> HEAD`
  por agente → `open_agent` (PTY) → **inyección del prompt tras 2,5 s** sin
  Enter (cola `deferred_writes` en `AtermApp`, paridad con la extensión).
- `run_compare`: `git worktree list --porcelain` + `git diff --stat HEAD` +
  `git log --oneline <base>..HEAD` → informe en ventana egui.
- `cleanup`: `git worktree remove --force` + `git branch -D`.
- **DECISIÓN RESUELTA** (inyección del prompt): timer diferido de 2,5 s
  (`ProHost::inject_prompt` → `deferred_writes`, drenado en `update`). Se
  descartó "detectar prompt listo" por frágil/por-proveedor.
- Gate: `ProImpl::gate` consulta `ProHost::is_pro()` y, si no, abre la compra.

Resto de la descripción original (referencia histórica del puerto):
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

### Fase 2 — Quick wins del sidecar (Community) — EN CURSO
Cablear en UI lo que el core YA soporta:
- ✅ **Notas + favorito** (2026-06-30): campos `notes`/`favorite` en el editor de
  sesión; ★ + indicador 🗒 en la fila; favoritos fijados arriba (Provider/Cascade).
- ✅ **Plantillas** (2026-06-30): nuevo `templates.rs` (store byte-compatible con
  el sidecar, `~/.config/aterm/templates.json`) + diálogo guardar/lanzar/borrar.
  Lanzar inyecta el prompt al PTY tras 2,5 s (`PanelAction::OpenTemplate`).
- ✅ **Backup/restore de catálogo** (2026-06-30): nuevo `backup.rs` (zip
  byte-compatible con el sidecar: manifest `aterm/catalog-backup` v1 +
  `config/{session-metadata,project-names,templates}.json`). Sección «Backup del
  catálogo» en el panel; restore recarga el catálogo en memoria.
- ✅ **Catálogo de tags** (2026-06-30): en el editor de sesión, chips marcables
  con todas las tags en uso (`metadata.all_tags()`) que se alternan en el campo.
- ✅ **Iconos de sesión/proyecto** (2026-06-30): nuevo `icons.rs` (store global
  en `~/.config/aterm/icons.json`, NO toca la metadata compartida). Campo «Icono»
  en el editor de sesión y de proyecto; emoji mostrado en fila y cabecera.

**Fase 2 ✅ COMPLETA** (2026-06-30).

### Fase 3 — Paridad Community restante — EN CURSO
- ✅ **Grupos/colecciones manuales** (2026-06-30): `groups.rs`
  (`~/.config/aterm/groups.json`, NO toca metadata compartida) + vista
  `GroupMode::Group` (crear/eliminar grupos, buckets con miembros) + asignación
  por checkboxes en el editor de sesión.
- ✅ **Comandos del proyecto/usuario** (2026-06-30): `commands.rs` — descubre
  `.claude/commands/**` (namespaced, descripción del frontmatter) + scripts de
  package.json (PM autodetectado)/Makefile/justfile/Cargo. Botón ⚙ por proyecto.
- ✅ **Multiselección + borrado por fecha** (2026-06-30): modo ☑ con barra de
  acciones en lote (Abrir/Eliminar/Limpiar) + diálogo «Por fecha…».
- ✅ **Paleta de acciones** (2026-06-30): Ctrl+Shift+P, ventana filtrable.
- ✅ **smartLaunch + nueva sesión multi-proyecto** (2026-06-30): ✨ recomendado +
  diálogo «Multi…».
- ✅ **Niveles de notificación** (2026-06-30): setting NotifyLevel. Los avisos
  idle/finish y alertas de coste se mueven a las automatizaciones Pro (Fase 4).

**Fase 3 ✅ COMPLETA** (2026-06-30) — salvo idle/finish/coste (→ Fase 4 Pro).

### Fase 4 — Resto de features Pro (todas con `require_pro`)
- Perfiles de espacio de trabajo (guardar/abrir conjuntos de sesiones).
- Dashboard Pro (egui + export CSV); resumen diario; automatizaciones idle.
- Export conversación a HTML.
- `portSession` / `portProject`.
- Memory graph.
- Configurar MCP desde UI (escribir config o copiar snippet).

### Fase 4.5 — Mejora de interfaz visual (UI/UX) 🎨
Pase de pulido visual de la app nativa. Hoy las ventanas/diálogos nuevos usan el
look por defecto de egui (funcional pero plano). Objetivo: una UI coherente,
densa y con marca, a la altura del terminal. Trabajo (incremental, sin tocar la
lógica ya cableada):
- **Sistema de diseño**: espaciados, radios, tipografía y paleta unificados
  derivados de `theme.rs` (las 10 paletas); tokens reutilizables en vez de
  literales sueltos (p. ej. el `★` amarillo hardcoded → color de la paleta).
- **Barra superior / chrome**: agrupar acciones con separadores e iconos
  consistentes; el botón ⚡ y el indicador de licencia con estilo de "pill".
- **Panel de sesiones**: refinar las tarjetas (jerarquía visual, hover, estados
  activo/favorito), chips de tag con color, cabeceras de grupo más claras.
- **Diálogos Pro y de licencia**: layout con rejilla consistente, botones
  primarios/secundarios diferenciados, estados vacíos con guía.
- **Toast/Informe**: estilo propio (no `Frame::popup` plano), animación de
  entrada/salida y auto-fade.
- **Iconografía**: revisar glifos (fuentes ya instaladas) y fallbacks; evitar
  cuadros vacíos por glifos ausentes.
- **Accesibilidad**: contraste suficiente en las 10 paletas (claras y oscuras),
  tamaños de toque, foco visible.
Se puede abordar como un pase transversal tras tener las features cableadas, o
por incrementos junto a cada fase. No requiere `--features pro`.

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

Fases 0 y 1 ✅ hechas (2026-06-30). Siguiente: **Fase 2 (quick wins del
sidecar: notas/favorito, plantillas, backup/restore, iconos/catálogo de tags)**.

Pendientes derivados de las Fases 0/1:
- Crear el repo privado `Aterm-labs/aterm-pro` y mover ahí `crates/aterm-pro`
  (hoy es path local). Ajustar `build.sh` para `--features pro` oficial.
- Probar `launch_parallel` en vivo (`cargo run -p aterm --features pro` dentro de
  un repo git con ≥2 agentes en PATH) y afinar el timing de inyección si hace falta.
- Si se quiere activación de licencia 100% offline, decidir Ed25519 (ver Fase 0).
