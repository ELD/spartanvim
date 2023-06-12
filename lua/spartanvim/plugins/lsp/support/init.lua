return {
  setup = function()
    require("spartanvim.plugins.lsp.support.configs")
    require("spartanvim.plugins.lsp.support.handlers").setup()
  end
}

