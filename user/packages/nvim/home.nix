{ pkgs, config, ... }: {

  home.file.".config/nvim/lua".source = ./lua;

  programs.neovim = {
    enable = true;

    initLua = ''
      require('config.options')
      require('config.vim-plug.lua')
    '';
  };

  
}
