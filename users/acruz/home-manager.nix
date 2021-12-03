{ config, lib, pkgs, ... }:

let sources = import ../../nix/sources.nix; in {
  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  # Packages I always want installed. Most packages I install using
  # per-project flakes sourced with direnv and nix-shell, so this is
  # not a huge list.
  home.packages = [
    pkgs.bat
    pkgs.dig
    pkgs.knot-dns
    pkgs.thefuck
    pkgs.fzf
    pkgs.git-crypt
    pkgs.htop
    pkgs.jq
    pkgs.rofi
    pkgs.go
    pkgs.gopls
    pkgs.tree
    pkgs.watch
    pkgs.zathura

    pkgs.tlaplusToolbox
    pkgs.tetex
  ];

  #---------------------------------------------------------------------
  # Env vars and dotfiles
  #---------------------------------------------------------------------

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
    MANPAGER = "less -FirSwX";
  };

  home.file.".inputrc".source = ./inputrc;

  xdg.configFile."i3/config".text = builtins.readFile ./i3;
  xdg.configFile."rofi/config.rasi".text = builtins.readFile ./rofi;

  # tree-sitter parsers
  xdg.configFile."nvim/parser/proto.so".source = "${pkgs.tree-sitter-proto}/parser";
  xdg.configFile."nvim/queries/proto/folds.scm".source =
    "${sources.tree-sitter-proto}/queries/folds.scm";
  xdg.configFile."nvim/queries/proto/highlights.scm".source =
    "${sources.tree-sitter-proto}/queries/highlights.scm";
  xdg.configFile."nvim/queries/proto/textobjects.scm".source =
    ./textobjects.scm;

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.gpg.enable = true;

  programs.bash = {
    enable = true;
    shellOptions = [];
    historyControl = [ "ignoredups" "ignorespace" ];
    initExtra = builtins.readFile ./bashrc;

    shellAliases = {
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gcp = "git cherry-pick";
      gdiff = "git diff";
      gl = "git prettylog";
      gp = "git push";
      gs = "git status";
      gt = "git tag";
    };
  };

  programs.direnv= {
    enable = true;
    config = {
      whitelist = {
        prefix= [
          "$HOME/code/go/src/github.com/hashicorp"
          "$HOME/code/go/src/github.com/mitchellh"
        ];

        exact = ["$HOME/.envrc"];
      };
    };
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-utils.extensionsFromVscodeMarketplace; [
      {
        name = "vscode-bazel";
        publisher = "BazelBuild";
        version = "0.5.0";
        sha256 = "0gjf42xjhzwbncd6c8p7c60m44bkhk2kcpa3qjg2vr619p0i5514";
      }
      {
        name = "xml";
        publisher = "DotJoshJohnson";
        version = "2.5.1";
        sha256 = "1v4x6yhzny1f8f4jzm4g7vqmqg5bqchyx4n25mkgvw2xp6yls037";
      }
      {
        name = "gitlens";
        publisher = "eamodio";
        version = "11.7.0";
        sha256 = "0apjjlfdwljqih394ggz2d8m599pyyjrb0b4cfcz83601b7hk3x6";
      }
      {
        name = "go";
        publisher = "golang";
        version = "0.29.0";
        sha256 = "1ky5xnl300m42ja8sh3b4ynn8k1nnrcbxxhn3c3g5bsyzsrr1nmz";
      }
      {
        name = "gc-excelviewer";
        publisher = "GrapeCity";
        version = "4.0.45";
        sha256 = "06zswxgsw861c8pbvvkwqx8q4lrfcpvdn04dd6qf6sghgl48s7gp";
      }
      {
        name = "terraform";
        publisher = "hashicorp";
        version = "2.17.0";
        sha256 = "00c31ll9lc48lrlls26c35pwxjiz19hqj4mpvrqb0v92avb71691";
      }
      {
        name = "latex-workshop";
        publisher = "James-Yu";
        version = "8.22.0";
        sha256 = "1j1qqwihzjlfs5w0nddd7msgi8r21jmgsyk2rg0abh9qi524f17f";
      }
      {
        name = "vscode-docker";
        publisher = "ms-azuretools";
        version = "1.18.0";
        sha256 = "0hhlhx3xy7x31xx2v3srvk67immajs6dm9h0wi49ii1rwx61zxah";
      }
      {
        name = "python";
        publisher = "ms-python";
        version = "2021.11.1422169775";
        sha256 = "1ax0lr0r9ip8pb3fzg462c00q98rlnpq5al5fkgaywcyx2k9pib3";
      }
      {
        name = "vscode-pylance";
        publisher = "ms-python";
        version = "2021.11.2";
        sha256 = "0di2skybp8jw3apyd74ifsrsp02hr84j92jpgkipdqyqmis4bbmm";
      }
      {
        name = "jupyter";
        publisher = "ms-toolsai";
        version = "2021.11.1001532801";
        sha256 = "1c5ja0lqqvxsil83qxw9ly4sjk2c64j5m3mh6afihylnll446m8r";
      }
      {
        name = "jupyter-keymap";
        publisher = "ms-toolsai";
        version = "1.0.0";
        sha256 = "0wkwllghadil9hk6zamh9brhgn539yhz6dlr97bzf9szyd36dzv8";
      }
      {
        name = "jupyter-renderers";
        publisher = "ms-toolsai";
        version = "1.0.4";
        sha256 = "01cspdjh40kzf015vqydyhcxlh7iqrgr16px181nyzvldb8ax9b8";
      }
      {
        name = "remote-containers";
        publisher = "ms-vscode-remote";
        version = "0.209.0";
        sha256 = "1mayr0kc20zfw21y13k35zbd65ir5cq3yw1n9kci73bbyhlg84fh";
      }
      {
        name = "remote-ssh";
        publisher = "ms-vscode-remote";
        version = "0.66.1";
        sha256 = "0qj2ihl74bk1fbixv0g1qzdvaxh4skqww22dyaf17rs6cjf19zps";
      }
      {
        name = "remote-ssh-edit";
        publisher = "ms-vscode-remote";
        version = "0.66.1";
        sha256 = "04sznznvgnp4x7w9mld3j02f9kkx6bxr95knjzbyi1az37bbbmyk";
      }
      {
        name = "vscode-remote-extensionpack";
        publisher = "ms-vscode-remote";
        version = "0.21.0";
        sha256 = "14l8h84kvnkbqwmw875qa6y25hhxvx1dsg0g07gdl6n8cv5kvy2g";
      }
      {
        name = "cpptools";
        publisher = "ms-vscode";
        version = "1.7.1";
        sha256 = "0hc6gnw00mri6hijm752zmhz26864dk8gxwa0yshy20hk9z29y6s";
      }
      {
        name = "ruby";
        publisher = "rebornix";
        version = "0.28.1";
        sha256 = "179g7nc6mf5rkha75v7rmb3vl8x4zc6qk1m0wn4pgylkxnzis18w";
      }
      {
        name = "vscode-commons";
        publisher = "redhat";
        version = "0.0.6";
        sha256 = "1b8nlhbrsg3kj27f1kgj8n5ak438lcfq5v5zlgf1hzisnhmcda5n";
      }
      {
        name = "vscode-yaml";
        publisher = "redhat";
        version = "1.2.2";
        sha256 = "06n4fxqr3lqmiyns9jdk3rdnanamcpzhrivllai8z9d997xmwcx6";
      }
      {
        name = "rust";
        publisher = "rust-lang";
        version = "0.7.8";
        sha256 = "039ns854v1k4jb9xqknrjkj8lf62nfcpfn0716ancmjc4f0xlzb3";
      }
      {
        name = "HCL";
        publisher = "wholroyd";
        version = "0.0.5";
        sha256 = "12lx9gjizy4m6lqjv9c10kmncdbbw7mrq69a5qisr69g9w9h6hwp";
      }
      {
        name = "vscode-ruby";
        publisher = "wingrunr21";
        version = "0.28.0";
        sha256 = "1gab5cka87zw7i324rz9gmv423rf5sylsq1q1dhfkizmrpwzaxqz";
      }
      {
        name = "vscode-proto3";
        publisher = "zxh404";
        version = "0.5.5";
        sha256 = "08gjq2ww7pjr3ck9pyp5kdr0q6hxxjy3gg87aklplbc9bkfb0vqj";
      }
    ];
    keybindings = [
      {
        key = "ctrl+c";
        command = "editor.action.clipboardCopyAction";
        when = "textInputFocus";
     }
    ];
    userSettings = {
      "editor.fontSize" = 12;
      "editor.tabSize" = 2;
      "update.channel" = "none";
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "robbyrussell";
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
      "source ${sources.theme-bobthefish}/fish_prompt.fish"
      "source ${sources.theme-bobthefish}/fish_right_prompt.fish"
      "source ${sources.theme-bobthefish}/fish_title.fish"
      (builtins.readFile ./config.fish)
      "set -g SHELL ${pkgs.fish}/bin/fish"
    ]);

    shellAliases = {
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gcp = "git cherry-pick";
      gdiff = "git diff";
      gl = "git prettylog";
      gp = "git push";
      gs = "git status";
      gt = "git tag";

      # Two decades of using a Mac has made this such a strong memory
      # that I'm just going to keep it consistent.
      pbcopy = "xclip";
      pbpaste = "xclip -o";
    };

    plugins = map (n: {
      name = n;
      src  = sources.${n};
    }) [
      "fish-fzf"
      "fish-foreign-env"
      "theme-bobthefish"
    ];
  };

  programs.git = {
    enable = true;
    userName = "André Cruz";
    userEmail = "acruz@cloudflare.com";
    signing = {
      key = "53F4511D689656CA198767BEA9ED80BE0FBB95F6";
      signByDefault = true;
    };
    aliases = {
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      root = "rev-parse --show-toplevel";
    };
    extraConfig = {
      branch.autosetuprebase = "always";
      color.ui = true;
      core.askPass = ""; # needs to be empty to use terminal for ask pass
      credential.helper = "store"; # want to make this more secure
      github.user = "mitchellh";
      push.default = "tracking";
      init.defaultBranch = "main";
    };
  };

  programs.go = {
    enable = true;
    goPath = "code/go";
    goPrivate = [ "github.com/mitchellh" "github.com/hashicorp" "rfc822.mx" ];
  };

  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    shortcut = "l";
    secureSocket = false;

    extraConfig = ''
      set -ga terminal-overrides ",*256col*:Tc"

      set -g @dracula-show-battery false
      set -g @dracula-show-network false
      set -g @dracula-show-weather false

      bind -n C-k send-keys "clear"\; send-keys "Enter"

      run-shell ${sources.tmux-pain-control}/pain_control.tmux
      run-shell ${sources.tmux-dracula}/dracula.tmux
    '';
  };

  programs.alacritty = {
    enable = true;

    settings = {
      env.TERM = "xterm-256color";

      key_bindings = [
        { key = "K"; mods = "Command"; chars = "ClearHistory"; }
        { key = "V"; mods = "Command"; action = "Paste"; }
        { key = "C"; mods = "Command"; action = "Copy"; }
        { key = "Key0"; mods = "Command"; action = "ResetFontSize"; }
        { key = "Equals"; mods = "Command"; action = "IncreaseFontSize"; }
        { key = "Subtract"; mods = "Command"; action = "DecreaseFontSize"; }
      ];
    };
  };

  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./kitty;
  };

  programs.i3status = {
    enable = true;

    general = {
      colors = true;
      color_good = "#8C9440";
      color_bad = "#A54242";
      color_degraded = "#DE935F";
    };

    modules = {
      ipv6.enable = false;
      "wireless _first_".enable = false;
      "battery all".enable = false;
    };
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;

    plugins = with pkgs; [
      customVim.vim-cue
      customVim.vim-fish
      customVim.vim-fugitive
      customVim.vim-misc
      customVim.vim-pgsql
      customVim.vim-tla
      customVim.vim-zig
      customVim.pigeon
      customVim.AfterColors

      customVim.vim-nord
      customVim.nvim-lspconfig
      customVim.nvim-treesitter
      customVim.nvim-treesitter-playground
      customVim.nvim-treesitter-textobjects

      vimPlugins.ctrlp
      vimPlugins.vim-airline
      vimPlugins.vim-airline-themes
      vimPlugins.vim-eunuch
      vimPlugins.vim-gitgutter

      vimPlugins.vim-markdown
      vimPlugins.vim-nix
      vimPlugins.typescript-vim
    ];

    extraConfig = (import ./vim-config.nix) { inherit sources; };
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "tty";

    # cache the keys forever so we don't get asked for a password
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
  };

  xresources.extraConfig = builtins.readFile ./Xresources;

  # Make cursor not tiny on HiDPI screens
  xsession.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
  };
}
