return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "simrat39/rust-tools.nvim",
    },
    config = function()
        require "spartanvim.plugins.lsp.configs"
        require("spartanvim.plugins.lsp.handlers").setup()
    end,
}
