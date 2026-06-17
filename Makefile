# aterm-workspace — orquestación de todos los repos del proyecto.
#
# Repos (submódulos):
#   aterm/           core Rust (app nativa + agent-sessions-cli)
#   agent-sessions/  extensión de VS Code (Community) — trae su propio aterm/
#   agent-sessions-pro/  módulo Pro (privado, open-core)
#   aterm-web/       landing (Vite + Vue)
#
# Uso típico:
#   make bootstrap     # clona submódulos e instala dependencias
#   make vsix          # .vsix Community (sin Pro)
#   make vsix-pro      # .vsix oficial (con Pro)
#   make web           # landing en local
#   make run           # app nativa Rust

.PHONY: help bootstrap update vsix vsix-pro web web-build run test clean

help:
	@echo "Targets: bootstrap update vsix vsix-pro web web-build run test clean"

## Clona/actualiza submódulos e instala dependencias de JS.
bootstrap:
	git submodule update --init --recursive
	cd agent-sessions && npm install --no-audit --no-fund
	cd aterm-web && npm install --no-audit --no-fund
	@echo "✓ Listo. 'make vsix' / 'make vsix-pro' / 'make web' / 'make run'."

## Trae el último commit de cada submódulo (rama remota).
update:
	git submodule update --remote --merge

## .vsix Community (extensión + sidecar, sin features Pro).
vsix:
	cd agent-sessions && git submodule update --init --recursive && ./scripts/build-vsix.sh $(TARGET)

## .vsix oficial (Community + módulo Pro).
vsix-pro:
	cd agent-sessions-pro && ./build.sh $(TARGET)

## Landing en local (http://localhost:5173).
web:
	cd aterm-web && npm run dev

web-build:
	cd aterm-web && npm run build

## App nativa Rust.
run:
	cd aterm && cargo run -p aterm

## Tests del core.
test:
	cd aterm && cargo test --workspace

clean:
	cd aterm && cargo clean || true
	rm -rf agent-sessions/out agent-sessions/bin aterm-web/dist
