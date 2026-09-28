{ pkgs, config, ... }: {

  programs.neovim = {
    enable = true;

    initLua = ''
      require('config.options')
    '';
  };

  home.file.".config/nvim/lua".source = ./lua;

}
