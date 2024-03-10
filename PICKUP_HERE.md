# Where I left off

- finished a basic pass at configuring LSP and language servers
- keybindings for common LSP actions, generally happy with this
- basic config for plugins, also happy with it
- completed merging of Mason and lspconfig configurations
  - I used the `cmd` argument in Lazy to load Mason on-demand outside of an LSP context
- removed some text handlers and notify overrides that clobbered noice.nvim
- did basic lspsaga config

# What's next
- [x] doing more with `lspsaga`
- [x] checking for any other incompleteness for LS setup
- [x] add keybinds for `lspsaga`
- [x] Move all UI-related plugins together into `ui.lua`
- [x] Install git plugins
- [ ] Reviewing integration with catppuccin scheme/plugin
- [ ] Set up uniform keybindings with predictable prefixes
  - Check `whichkey` for key conflicts

# What's eventually?
- [ ] Set up DAPs
- [ ] Set up none-ls for linting and formatting

