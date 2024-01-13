{
  allowUnfree = true;
  use-xdg-base-directories = true;
  packageOverrides = pkgs: with pkgs; {
    thaynePackages = pkgs.buildEnv {
      name = "thaynePackages";
      paths = [
        gnupg
        iterm2
        ripgrep
        fzf
        fd
        pkg-config
      ];
    };
  };
}
