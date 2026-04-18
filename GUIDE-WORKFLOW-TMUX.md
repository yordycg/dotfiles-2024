# 🚀 Workflow Profesional: Hyprland + Tmux

Este documento resume la estrategia para gestionar proyectos y materias de forma eficiente, evitando el "efecto espejo" y maximizando la persistencia.

## 1. El Concepto: "Sesiones por Contexto"
En lugar de tener una sola sesión de Tmux global, creamos una **sesión independiente para cada proyecto o materia**.

*   **Sesión "Algebra"**: Contiene tus apuntes en LaTeX o ejercicios en Python.
*   **Sesión "Programacion_I"**: Contiene tu Neovim con archivos C++ y tu compilador.
*   **Sesión "Dotfiles"**: Para configurar tu sistema sin mezclarlo con tus estudios.

---

## 2. Comandos Clave (Tu arsenal)

### En la Shell (Zsh/Bash/Fish)
*   `tat`: (Tu función personalizada) Entra a una carpeta y escribe `tat`. Crea una sesión con el nombre de la carpeta o se une si ya existe.
*   `tmux ls`: Lista todas tus sesiones (materias/proyectos) activas en segundo plano.
*   `tks`: (Tu alias) Mata el servidor de Tmux (cierra todo). Úsalo solo cuando quieras "limpiar mesa" de verdad.

### Dentro de Tmux (Atajos Pro)
*   `Prefix + s`: **El Selector**. Te muestra una lista visual de todas tus sesiones. Usa las flechas y Enter para saltar de "Algebra" a "Programacion" en 1 segundo.
*   `Prefix + d`: **Detach**. Te sales de Tmux a la terminal normal, pero **todo sigue corriendo** en segundo plano.
*   `Prefix + c`: Crea una nueva "ventana" (pestaña) dentro de la misma materia.
*   `Prefix + n / p`: Salta entre ventanas (ej: Ventana 1: Código, Ventana 2: Servidor/Logs).

---

## 3. Resolución de Problemas: El "Efecto Espejo"
Si abres dos terminales de Hyprland y en ambas haces `tat` en la misma carpeta, verás lo mismo en ambas (espejo).

**Soluciones profesionales:**
1.  **Usa Ventanas de Tmux**: En lugar de abrir dos terminales de Hyprland, usa una sola y crea ventanas internas con `Prefix + c`.
2.  **Paneles (Splits)**: Usa `Prefix + %` (vertical) o `Prefix + "` (horizontal) para ver código y terminal al mismo tiempo.
3.  **Grouped Sessions** (Si realmente necesitas dos terminales de Hyprland separadas):
    `tmux new-session -t nombre_sesion`

---

## 4. Integración con Hyprland
*   **No auto-inicies Tmux en `.zshrc`**: Deja que cada terminal sea "libre" al nacer.
*   **Usa un Scratchpad**: Configura una tecla en Hyprland para mostrar/ocultar una terminal con una sesión de Tmux "Global" (para música, btop, etc.).

---

## 5. Próximos pasos (Mejoras Futuras)
*   [ ] Crear función `fp` (Fuzzy Project) para buscar carpetas y entrar con `tat`.
*   [ ] Instalar `tmux-resurrect` para que las sesiones sobrevivan a un apagado del PC.
*   [ ] Configurar una línea de estado (Status Bar) minimalista en Tmux que combine con tu tema de Hyprland/Waybar.
