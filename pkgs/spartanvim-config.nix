{ pkgs, lib, ... }:
let
  buildLuaConfigPlugin = { configDir, moduleName }:
    let pname = "${moduleName}";
    in (pkgs.vimUtils.buildVimPluginFrom2Nix {
      inherit pname;
      version = "dev";
      src = configDir;
      meta = with lib; {
        homepage = "https://github.com/ELD/spartanvim.git";
        description = "Spartanvim configuration";
        license = licenses.mit;
        maintainers = [ maintainers.ELD ];
      };
    });
in buildLuaConfigPlugin {
  configDir = ../config;
  moduleName = "spartanvim";
}
