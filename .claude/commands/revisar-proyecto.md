---
description: Revisión integral del proyecto aterm (Rust + extensión VS Code)
argument-hint: "[rust|vscode|rapido|completo] (opcional)"
---

Realiza una revisión del proyecto **aterm** usando la skill `revisar-proyecto`.

Alcance solicitado: **$ARGUMENTS**
(si está vacío, asume `completo`: workspace Cargo + extensión VS Code).

Sigue exactamente el procedimiento de la skill `revisar-proyecto`:
ejecuta las comprobaciones pertinentes, no arregles nada sin avisar, y
entrega un informe en español con findings priorizados (🔴/🟡/🟢) y
los comandos exactos que ejecutaste con su resultado real (verde/rojo).
