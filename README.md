# aterm-workspace

Meta-repo de **[Aterm-labs](https://github.com/Aterm-labs)**: agrupa todos los
repos del proyecto como submódulos y centraliza setup, desarrollo y empaquetado.

```
aterm-workspace/
├── aterm/           # core Rust: app nativa + agent-sessions-cli (sidecar)
├── agent-sessions/  # extensión de VS Code (Community). Trae aterm/ anidado.
├── aterm-pro/       # módulo Pro (privado, open-core)
└── aterm-web/       # landing (Vite + Vue)
```

> `agent-sessions` incluye su propio submódulo `aterm` (para ser autocontenido),
> así que tras un clon recursivo verás `aterm/` también dentro de
> `agent-sessions/`. Es lo esperado: el build de la extensión usa ese core.

## Empezar

```bash
git clone --recurse-submodules git@github.com:Aterm-labs/aterm-workspace.git
cd aterm-workspace
make bootstrap        # init submódulos + npm install
```

## Tareas (Makefile)

| Comando | Qué hace |
| --- | --- |
| `make bootstrap` | Clona submódulos e instala dependencias JS. |
| `make update` | Trae el último commit de cada submódulo. |
| `make vsix` | `.vsix` **Community** (extensión + sidecar). |
| `make vsix-pro` | `.vsix` **oficial** (Community + Pro). |
| `make web` | Landing en local (`localhost:5173`). |
| `make web-build` | Build estático de la web (`aterm-web/dist`). |
| `make run` | App nativa Rust (`cargo run -p aterm`). |
| `make test` | Tests del core (`cargo test --workspace`). |

Pasa un target de plataforma a los `.vsix` con `make vsix TARGET=linux-x64`
(o `darwin-arm64`, `win32-x64`, …).

## Trabajar en un repo concreto

Cada submódulo es un repo git normal con su propia rama. Para contribuir, entra
en él (`cd agent-sessions`), trabaja en `main`, commitea y pushea a su origin.
Luego, en el workspace, `git add <submódulo> && git commit` actualiza el puntero
a esa nueva versión.
