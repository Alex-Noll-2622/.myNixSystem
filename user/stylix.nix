{ pkgs, config, ... }: {
  stylix = {
    enable = true;
    image = ./backgrounds/dark-souls.png; # Or use base16Scheme
    polarity = "dark"; # or "light.."
    fonts = {
      sizes = {
        terminal = 8.5;
	popups = 8.5;
	desktop = 8.5;
	applications = 8.5;
      };
      serif = {
        package = pkgs.nerd-fonts.go-mono;
        name = "Go Mono Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.go-mono;
        name = "Go Mono Nerd Font";
      };
      monospace = {
        package = pkgs.nerd-fonts.go-mono;
        name = "Go Mono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
  
}

