{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "thayne";
    homeDirectory = "/Users/thayne";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "25.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = [
      # It is sometimes useful to fine-tune packages, for example, by applying
      # overrides. You can do that directly here, just don't forget the
      # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # You can also create simple shell scripts directly inside your
      # configuration. For example, this adds a command 'my-hello' to your
      # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
      pkgs.anki-bin
      pkgs.ghostty-bin
      pkgs.vlc-bin

      pkgs.aider-chat
      pkgs.bat
      pkgs.bitwarden-cli
      pkgs.btop
      pkgs.claude-code
      pkgs.devenv
      pkgs.docker-client
      pkgs.fd
      pkgs.ffmpeg
      pkgs.fzf
      pkgs.gh
      pkgs.graphviz
      pkgs.lesspipe
      pkgs.macpm
      pkgs.mc
      pkgs.mosh
      pkgs.ncdu
      # pkgs.neovim  # Managed via programs.neovim instead
      pkgs.nixfmt
      pkgs.opencode
      pkgs.pstree
      pkgs.ripgrep
      pkgs.ruff
      pkgs.statix
      pkgs.texliveFull
      pkgs.tmux
      pkgs.tombi
      pkgs.tree
      pkgs.yubikey-manager
      pkgs.xz
      pkgs.zsh-completions
      pkgs.nix-zsh-completions

      pkgs.yt-dlp

    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/thayne/etc/profile.d/hm-session-vars.sh
    #
    sessionVariables = {
      # EDITOR = "emacs";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.vim = {
    enable = true;
    extraConfig = ''
      source $HOME/.vimrc
    '';
    plugins = with pkgs.vimPlugins; [
      vim-colors-solarized
      rainbow
      vim-nix
      stan-vim

      vim-fugitive
      vim-gitgutter

      fzf-vim
      fzf-wrapper

      ale

      copilot-vim
    ];
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = false; # Keep vim pointing to vim for now
    vimdiffAlias = true;
    defaultEditor = false;
    withRuby = false;
    withPython3 = false;

    # Don't manage the config file - we have a custom Lua config
    extraConfig = ''
      " Neovim config is managed manually in ~/.config/nvim/
      " This just ensures the init.backup.lua is loaded
      lua dofile(vim.fn.stdpath('config') .. '/init.backup.lua')
    '';

    # LSP servers, formatters, linters
    extraPackages = with pkgs; [
      # LSP servers
      nil # Nix LSP
      pyright # Python LSP
      ruff # Python linting/formatting
      clang-tools # C++ LSP (clangd)
      haskell-language-server # Haskell LSP
      texlab # LaTeX LSP

      # Formatters
      nixfmt # Nix formatter
      # ruff also used for formatting

      # Linters
      statix # Nix linter
      hlint # Haskell linter

      # Tools for fuzzy finder
      ripgrep
      fd
      fzf
      bat
    ];
  };
}
