{ pkgs, config, ... }: {

  home.file.".config/nvim/lua".source = ./lua;

  programs.neovim = {
    enable = true;

    plugins = [
      pkgs.vimPlugins.vim-devicons
    ];

    initLua = ''
      require('options')
  '';
  };

  
}
