{ pkgs, ... }:
let
  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    viAlias = true;
    vimAlias = true;

    withPython3 = true;
    withRuby = true;
    withNodeJs = true;

    customRc = ''
      lua << EOF
      -- bootstrap lazy.nvim, LazyVim and your plugins
      require('spartanvim.config.lazy').setup()
      EOF
    '';

    plugins = [{
      plugin = pkgs.spartanvim-config;
      optional = false;
    }];
  };
in pkgs.wrapNeovimUnstable pkgs.neovim (neovimConfig // { wrapRc = true; })
