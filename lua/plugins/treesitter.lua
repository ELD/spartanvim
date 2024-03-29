return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/parsers")
    local configs = require("nvim-treesitter.configs")

    require "nvim-treesitter.install".compilers = { "clang" }

    configs.setup {
      -- A list of parser names, or "all"
      ensure_installed = { "c", "lua", "cpp", "bash", "bibtex", "clojure", "cmake", "css", "gitignore", "gitcommit", "git_rebase", "gitattributes", "json", "python", "scss", "scheme", "sql", "toml", "typescript", "yaml", "rust", "vue", "javascript", "markdown", "markdown_inline" },
      auto_install = false,
      sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
      ignore_install = { "hack", "rnoweb" }, -- List of parsers to ignore installing
      parser_install_dir = vim.fn.stdpath("data") .. "/parsers",
      autopairs = {
        enable = true,
      },
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
      },
      indent = { enable = true, disable = { "yaml" } },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    }
  end
}

