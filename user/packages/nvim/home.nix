{ pkgs, config, ... }: {

  programs.neovim = {
    enable = true;

    extraConfig = ''
      require('config.options')
    '';
  };

  home.file.".config/nvim/lua/options.lua".source = ./lua/options.lua;

}
