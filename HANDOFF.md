# Handoff — estado del proyecto y cómo continuar

> Documento de traspaso para retomar el trabajo **desde este meta-repo**
> (`aterm-workspace`). Última actualización: 2026-06-16.

## Qué es esto

Monorepo de orquestación de **Aterm-labs**. Agrupa los repos como submódulos y
centraliza el tooling (`Makefile`). La guía técnica viva está en `CLAUDE.md`.

```
aterm-workspace/            github.com/Aterm-labs/aterm-workspace  (público)
├── aterm/                  core Rust: app nativa + agent-sessions-cli   (público)
├── agent-sessions/         extensión VS Code · Community (open-core)     (público)
│   └── aterm/              submódulo anidado (core, para el sidecar)
├── aterm-pro/              módulo Pro de la extensión                    (PRIVADO)
└── aterm-web/              landing (Vite + Vue)                          (público)
```

Todos en rama `main`.

## Empezar a trabajar

```bash
git clone --recurse-submodules git@github.com:Aterm-labs/aterm-workspace.git
cd aterm-workspace
make bootstrap     # init submódulos + npm install
```

Abre **esta carpeta** en VS Code / Claude Code (aquí están `CLAUDE.md` y
`.claude/` con el comando/skill `revisar-proyecto`).

| Comando | Qué hace |
| --- | --- |
| `make vsix` | `.vsix` Community (extensión + sidecar) |
| `make vsix-pro` | `.vsix` oficial (Community + Pro) |
| `make web` / `make web-build` | landing en local / build |
| `make run` / `make test` | app nativa Rust / tests del core |

## Qué se hizo (resumen)

- **Issues #1–#7 + extra**: prompt en compact, control de notificaciones,
  preview estilada, borrado por fecha/multiselección, abrir varias, subproyectos
  + grupos manuales, iconos/emojis, añadir carpeta al workspace, comandos de
  proyecto y menú de acciones «⋯». Fix del % de contexto (`claudeContextWindow`).
- **Modelo open-core (Pro)**: gate con trial 14 días + licencias **Lemon Squeezy**
  (validación online). Features Pro: comparativa paralela, plantillas, perfiles
  de espacio de trabajo, dashboard Pro (panel con gráficas + CSV), exportar
  conversación a HTML, automatizaciones (idle + resumen diario).
- **Split open-core**: el código Pro vive en `aterm-pro` (privado); la extensión
  Community en `agent-sessions`, que lo carga dinámicamente (`require("./pro")`).
- **Web** (`aterm-web`) y **reorganización** de todo a la org `Aterm-labs` con
  este meta-repo.

## Pendientes (accionables)

1. **Activar la tienda de Lemon Squeezy** (los productos/links ya existen).
2. **Precios reales** en `aterm-web/src/site.js` (`PRICING`) y, opcional,
   `PRODUCT_ID` en `agent-sessions/src/license.ts` para restringir claves.
3. **Borrar el duplicado** `Zarritas/aterm-pro` (repo fantasma, solo commit
   inicial): `gh repo delete Zarritas/aterm-pro --yes`.
4. **Publicar la extensión**: decidir qué se publica en Marketplace/Open VSX
   (Community) y cómo se distribuye el `.vsix` Pro. Empezar a **etiquetar
   releases** en `agent-sessions` (los tags `v1.x` quedaron en `aterm`).
5. **Quitar/ocultar el comando `(debug)`** de estado de prueba antes del release
   público (ya está oculto salvo `ExtensionMode.Development`).
6. **Presupuestos por proyecto**: reservados para un futuro **tier Team/cloud**
   (no encajan en local mono-usuario).

## Gotchas

- **Submódulos**: tras tocar un repo, commitea/pushea EN ÉL y luego actualiza el
  pin aquí (`git add <submódulo> && git commit`). `make update` trae los últimos.
- **Build Pro**: `aterm-pro/build.sh` compila `agent-sessions` (que usa su
  submódulo `aterm` para el sidecar) e inyecta `out/pro/`. El `.vsix` Community
  (`agent-sessions/scripts/build-vsix.sh`) NO incluye Pro.
- **Licencias**: offline-cacheadas; sin `out/pro` las acciones Pro muestran
  «edición Community». `agent-sessions/src/license.ts` tiene `BUY_URL_*`.
- **aterm** ya no contiene la extensión (se separó); su `CLAUDE.md` se movió aquí.
