return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "simrat39/rust-tools.nvim",
    },
    config = function()
        -- require "plugins.lsp.configs"
        -- require("plugins.lsp.handlers").setup()
    end,
}
