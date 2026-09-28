{ pkgs, config, ... }: {

  programs.neovim = {
    enable = true;

    extraConfig = ''
      require("option")
    '';
  };

  home.file.".config/nvim/lua".source = ./lua;

}
