# Repository Guidelines

## Project Structure & Module Organization

This repository is a Lua-based Neovim configuration. `init.lua` loads core settings, keymaps, plugins, Mason, and LSP setup. Core editor settings live in `lua/basic.lua` and `lua/keybindings.lua`. Plugin specs are split by feature in `lua/plugins/*.lua` and assembled from `lua/plugins/init.lua`. LSP server definitions live in `lua/lsp/servers/`, with shared behavior in `lua/lsp/lsp.lua` and UI customization in `lua/lsp/ui.lua`. Filetype overrides belong in `ftplugin/`. Swift snippets and templates live under `lua/snippets/swift/` and `lua/util/template/Swift/`.

## Build, Test, and Development Commands

- `nvim --headless "+Lazy! sync" +qa`: install or update plugins from `lua/plugins` and `lazy-lock.json`.
- `nvim --headless "+checkhealth" +qa`: run Neovim health checks for plugins, providers, and LSP dependencies.
- `nvim --headless "+luafile init.lua" +qa`: smoke-test that the config loads without Lua syntax errors.
- `nvim`: run the configuration interactively after changes.

There is no separate build step; validate with plugin sync, health checks, and relevant filetypes.

## Coding Style & Naming Conventions

Use Lua modules that return tables for plugin specs and server configs. Keep one plugin per `lua/plugins/<name>.lua` file and require it from `lua/plugins/init.lua`. Use tabs for indentation to match the current style. Prefer names that mirror plugin or server names, such as `conform-nvim.lua`, `rust_analyzer.lua`, and `sourcekit.lua`. Keep comments concise and focused on non-obvious behavior.

## Testing Guidelines

No automated test suite is currently present. For config changes, run the headless load command and manually verify affected workflows in Neovim. For LSP changes, open a representative filetype such as `*.swift`, `*.rs`, `*.cpp`, or `*.go` and confirm diagnostics, formatting, and completion. For snippet or template changes, expand the affected snippet or generator output in a temporary project.

## Commit & Pull Request Guidelines

Recent commits use short, imperative messages, often in Chinese, with occasional prefixes such as `fix:`. Keep subjects concise and specific, for example `fix: 修复 Swift 格式化配置` or `增加 clangd 配置`. Pull requests should describe the affected editor area, list manual validation steps, and mention required external tools such as `swiftformat`, language servers, or debug adapters. Include screenshots only for visible UI/theme changes.

## Security & Configuration Tips

Do not commit machine-local secrets, private paths, or generated project files. Keep `lazy-lock.json` changes intentional and tied to plugin updates. When adding language tooling, prefer Mason-managed tools unless the configuration clearly requires a system installation.
