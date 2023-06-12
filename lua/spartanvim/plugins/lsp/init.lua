local M = {}

M.setup = function()
  require "spartanvim.plugins.lsp.configs"
  require("spartanvim.plugins.lsp.handlers").setup()
end

return M

