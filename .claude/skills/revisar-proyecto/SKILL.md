---
name: revisar-proyecto
description: Revisión integral del proyecto aterm — valida el workspace Cargo (check/test/clippy/fmt) y la extensión de VS Code (TypeScript/lint/build del .vsix), reportando findings priorizados. Úsala cuando el usuario pida "revisar el proyecto", una "revisión de aterm", comprobar que todo compila/pasa, o auditar el estado antes de un commit/release.
---

# Revisar aterm

`aterm` es un workspace Cargo (crates `agent-sessions`, `agent-sessions-cli`,
`aterm`) más una **extensión de VS Code** en TypeScript (`vscode-extension/`).
Una revisión cubre **ambas mitades** salvo que el usuario acote el alcance.

## Alcance

El argumento del comando (`$ARGUMENTS`) decide qué revisar:

- `rust` → solo el workspace Cargo.
- `vscode` → solo la extensión de VS Code.
- `rapido` → solo `cargo check` + `cargo clippy` (sin tests ni build de la extensión).
- `completo` / vacío → todo lo de abajo.

## Procedimiento

Trabaja desde la raíz del repo (`/home/zarras/Documentos/aterm`). Ejecuta cada
bloque, **captura el resultado real** (no asumas que pasa) y anótalo. Si un
comando no existe (p. ej. falta `cargo-clippy`), dilo y sigue; no lo des por verde.

### 1. Estado del repo
- `git status --short` y `git log --oneline -5` para situar el trabajo en curso
  y los cambios sin commitear (hay edits pendientes en `vscode-extension/` y `CLAUDE.md`).

### 2. Workspace Cargo (alcance `rust`/`rapido`/`completo`)
- `cargo check --workspace` — compilación.
- `cargo clippy --workspace --all-targets -- -D warnings` — lints (trata los warnings como fallo).
- `cargo fmt --all -- --check` — formato (no reformatees sin avisar).
- `cargo test --workspace` — la base son **60 tests en `agent-sessions` + 15 en `aterm`**;
  si el conteo bajó, es una regresión a reportar.
- Solo en `completo`: `cargo build --release` (compila con `lto thin`) si hay tiempo/dudas de release.

### 3. Extensión de VS Code (alcance `vscode`/`completo`)
Trabaja en `vscode-extension/`:
- Si falta `node_modules`, `npm ci` (o `npm install`).
- `npm run compile` o `npx tsc --noEmit -p .` — typecheck de TypeScript.
- `npm run lint` si existe el script en `package.json`.
- No ejecutes `scripts/build-vsix.sh` salvo que el usuario lo pida (compila el
  sidecar por plataforma y tarda).

### 4. Coherencia del proyecto (siempre)
- Revisa que `CLAUDE.md` siga reflejando el estado real si tocaste algo grande.
- Verifica las **3 divergencias del vendor** si se tocó `agent-sessions`
  (ver sección "Sincronizar el vendor" en `CLAUDE.md`): `service_status` fuera de
  `lib.rs`, `windows-sys` como dep `[target.'cfg(windows)']`, y el campo
  `SessionMetadata::persisted`.
- Recuerda: `agent-sessions` es **read-only por diseño** (rutas derivadas del HOME);
  marca cualquier provider que acepte paths del caller.

## Reglas

- **No arregles nada sin avisar.** Esta skill audita y reporta. Si encuentras algo
  trivial, propón el fix; aplícalo solo si el usuario lo confirma o lo pidió.
- **Reporta resultados reales.** Si un test falla, pega la salida relevante; si te
  saltaste un paso, dilo.
- Responde en **español**.

## Formato del informe

```
## Revisión de aterm — <alcance>

### Comandos ejecutados
- `cargo check --workspace` → ✅ / ❌ (resumen)
- ...

### Findings
🔴 Crítico — <qué rompe y dónde: archivo:línea>
🟡 Atención — <warning/lint/deuda>
🟢 OK / menor — <nota>

### Recomendación
<una línea: listo para commit / arreglar X primero / etc.>
```

Ordena los findings por severidad. Si todo está verde, dilo claramente y
no inventes problemas.
