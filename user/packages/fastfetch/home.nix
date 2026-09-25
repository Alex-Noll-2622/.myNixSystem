{ pkgs, config, ... }: {
  
  home.file.".config/fastfetch/config.jsonc".source = ./config.jsonc;

}
