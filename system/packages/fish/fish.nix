{ pkgs, ... }:

{
  programs.fish.enable = true;

  users.users.alexnoll = {
    isNormalUser = true;
    shell = pkgs.fish; 
  };
}
