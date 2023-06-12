local M = {}

M.setup = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end

  vim.opt.rtp:prepend(lazypath)

  require("spartanvim.config.autocommands")
  require("spartanvim.config.icons")
  require("spartanvim.config.keybindings")
  require("spartanvim.config.settings")

  local status_ok, lazy = pcall(require, "lazy")
  if not status_ok then
    return
  elseif lazy == nil then
    return
  end

  lazy.setup("plugins", {
    git = {
      url_format = "https://github.com/%s.git"
    }
  })
end

return M

