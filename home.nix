{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nathan";
  home.homeDirectory = "/home/nathan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "24.05";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Development tools
    github-cli
    luarocks
    python-pipx
    python-pyquery
    python-pywal16
    python-pywalfox
    python-requests

    # Additional utilities
    pyprland
    wallust
    cliphist
    cava
    asciiquarium
    bpytop
    bluetui
    ncspot
    yt-dlp
    jq
    gjs
    glib.dev
    gvfs
    gvfs-mtp
    polkit_gnome
    polkit-kde-agent
    qt5.qtwayland
    qt6.qtwayland
    qt5ct
    qt6ct
    kvantum
    nwg-look
    onedrive
    snapd
    sof-firmware
    timeshift
    debtap
    gdm-settings
    gnome-system-monitor
    dolphin
    eog
    mousepad
    nano
    vi
    vim
    wallust
    xclip
    xdg-user-dirs
    xdg-utils
    xf86-video-nouveau
    xorg.xev
    xorg.xinit
    wireshark-qt
    zen-browser
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # Hyprland configuration
    ".config/hypr/hyprland.conf".source = ./hypr/.config/hypr/hyprland.conf;
    ".config/hypr/lid-handle.sh".source = ./hypr/.config/hypr/lid-handle.sh;
    ".config/hypr/wallpaper.sh".source = ./hypr/.config/hypr/wallpaper.sh;
    ".config/hypr/RofiSearch.sh".source = ./hypr/.config/hypr/RofiSearch.sh;

    # Waybar configuration
    ".config/waybar/config".source = ./waybar/.config/waybar/config;
    ".config/waybar/style.css".source = ./waybar/.config/waybar/style.css;
    ".config/waybar/refresh.sh".source = ./waybar/.config/waybar/refresh.sh;
    ".config/waybar/scripts/colorpicker.sh".source = ./waybar/.config/waybar/scripts/colorpicker.sh;

    # Kitty configuration
    ".config/kitty/kitty.conf".source = ./kitty/.config/kitty/kitty.conf;
    ".config/kitty/current-theme.conf".source = ./kitty/.config/kitty/current-theme.conf;

    # Rofi configuration
    ".config/rofi/config.rasi".source = ./rofi/.config/rofi/config.rasi;
    ".config/rofi/master-config.rasi".source = ./rofi/.config/rofi/master-config.rasi;

    # SwayNC configuration
    ".config/swaync/config.json".source = ./swaync/.config/swaync/config.json;
    ".config/swaync/style.css".source = ./swaync/.config/swaync/style.css;
    ".config/swaync/refresh.sh".source = ./swaync/.config/swaync/refresh.sh;

    # Wlogout configuration
    ".config/wlogout/layout".source = ./wlogout/.config/wlogout/layout;
    ".config/wlogout/style.css".source = ./wlogout/.config/wlogout/style.css;

    # Wofi configuration
    ".config/wofi/config".source = ./wofi/.config/wofi/config;
    ".config/wofi/style.css".source = ./wofi/.config/wofi/style.css;

    # Fastfetch configuration
    ".config/fastfetch/config.jsonc".source = ./fastfetch/.config/fastfetch/config.jsonc;
    ".config/fastfetch/config-compact.jsonc".source = ./fastfetch/.config/fastfetch/config-compact.jsonc;

    # Neovim configuration
    ".config/nvim/init.lua".source = ./nvim/.config/nvim/init.lua;
    ".config/nvim/lazy-lock.json".source = ./nvim/.config/nvim/lazy-lock.json;
    ".config/nvim/lazyvim.json".source = ./nvim/.config/nvim/lazyvim.json;
    ".config/nvim/LICENSE".source = ./nvim/.config/nvim/LICENSE;
    ".config/nvim/README.md".source = ./nvim/.config/nvim/README.md;
    ".config/nvim/stylua.toml".source = ./nvim/.config/nvim/stylua.toml;

    # Neovim lua config
    ".config/nvim/lua/config/autocmds.lua".source = ./nvim/.config/nvim/lua/config/autocmds.lua;
    ".config/nvim/lua/config/keymaps.lua".source = ./nvim/.config/nvim/lua/config/keymaps.lua;
    ".config/nvim/lua/config/lazy.lua".source = ./nvim/.config/nvim/lua/config/lazy.lua;
    ".config/nvim/lua/config/options.lua".source = ./nvim/.config/nvim/lua/config/options.lua;

    # Neovim plugins
    ".config/nvim/lua/plugins/colors.lua".source = ./nvim/.config/nvim/lua/plugins/colors.lua;
    ".config/nvim/lua/plugins/example.lua".source = ./nvim/.config/nvim/lua/plugins/example.lua;

    # Zsh configuration
    ".zshrc".source = ./zshrc/.zshrc;

    # Wallpapers
    "Pictures/wallpapers".source = ./wallpapers;
    "Pictures/walls".source = ./wallpapers/wallpapers/walls;
  };

  # You can also manage environment variables but you will have to manually
  # source the file or add it to your shell configuration.
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    FILE_MANAGER = "thunar";
    MENU = "rofi -show drun";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Bibata-Modern-Ice";
    HYPRCURSOR_SIZE = "24";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    GDK_SCALE = "1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    history = {
      size = 10000;
      save = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    shellAliases = {
      ls = "eza -a --icons";
      ll = "eza -al --icons";
      lt = "eza -a --tree --level=1 --icons";
      hypr = "cd /home/nathan/.config/hypr; nvim .";
      install = "yay -S";
      uninstall = "yay -Rns";
      school = "cd /home/nathan/repos/school";
      pacup = "sudo pacman -Rns $(pacman -Qdtq)";
      grep = "grep --color=auto";
      pool = "clear && asciiquarium";
      fonts = "fc-list -f \"%{family}\\n\"";
      hypr = "cd ~/.config/hypr/";
      tasks = "bpytop";
      viruscheck = "sudo clamscan -r /";
      spot = "ncspot";
      clear = "clear && fastfetch";
      connect = "ssh ssh.nathangrilliot.com";
      diskinfo = "df -h";
    };
    initExtra = ''
      # Enable Powerlevel10k instant prompt
      fastfetch
      if [[ -r "${config.xdg.cacheHome}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${config.xdg.cacheHome}/p10k-instant-prompt-${(%):-%n}.zsh"
      fi

      # git repository greeter
      last_repository=
      check_directory_for_new_repository() {
       current_repository=$(git rev-parse --show-toplevel 2> /dev/null)
       
       if [ "$current_repository" ] && \
          [ "$current_repository" != "$last_repository" ]; then
        onefetch --include-hidden
       fi
       last_repository=$current_repository
      }
      cd() {
       builtin cd "$@"
       check_directory_for_new_repository
      }

      # optional, greet also when opening shell directly in repository directory
      check_directory_for_new_repository

      # Set-up FZF key bindings (CTRL R for fuzzy history finder)
      source <(fzf --zsh)

      export PATH=$PATH:/home/nathan/.spicetify
      export PATH=$PATH:/home/nathan/.cargo/bin
      export PATH="$PATH:/home/nathan/.local/bin"

      # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };

  # Enable git
  programs.git = {
    enable = true;
    userName = "Nathan";
    userEmail = "your-email@example.com";
  };

  # Enable fzf
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Enable eza (better ls)
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  # Enable bat (better cat)
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      italic-text = "always";
    };
  };

  # Enable direnv
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Enable starship prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = "$all$character";
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };

  # Enable gpg
  programs.gpg = {
    enable = true;
  };

  # Enable ssh
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  # Enable kitty
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      background_opacity = "0.95";
      window_padding_width = 8;
      confirm_os_window_close = 0;
    };
  };

  # Enable neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Enable waybar
  programs.waybar = {
    enable = true;
  };

  # Enable rofi
  programs.rofi = {
    enable = true;
    theme = "gruvbox-dark-hard";
  };

  # Enable swaync
  programs.swaync = {
    enable = true;
  };

  # Enable wlogout
  programs.wlogout = {
    enable = true;
  };

  # Enable wofi
  programs.wofi = {
    enable = true;
  };

  # Enable fastfetch
  programs.fastfetch = {
    enable = true;
  };


  # Enable xdg
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  # Enable services
  services = {
    # Enable gpg-agent
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };

    # Enable ssh-agent
    ssh-agent = {
      enable = true;
    };

    # Enable syncthing
    syncthing = {
      enable = true;
    };

    # Enable onedrive
    onedrive = {
      enable = true;
    };

    # Enable dropbox
    dropbox = {
      enable = true;
    };

    # Enable nextcloud
    nextcloud = {
      enable = true;
    };

    # Enable google-drive-ocamlfuse
    google-drive-ocamlfuse = {
      enable = true;
    };

    # Enable megasync
    megasync = {
      enable = true;
    };

    # Enable pcloud
    pcloud = {
      enable = true;
    };

    # Enable insync
    insync = {
      enable = true;
    };

    # Enable seafile
    seafile = {
      enable = true;
    };

    # Enable owncloud
    owncloud = {
      enable = true;
    };

    # Enable spideroak
    spideroak = {
      enable = true;
    };

    # Enable tresorit
    tresorit = {
      enable = true;
    };

    # Enable box
    box = {
      enable = true;
    };

    # Enable drive
    drive = {
      enable = true;
    };

    # Enable hubic
    hubic = {
      enable = true;
    };

    # Enable jottacloud
    jottacloud = {
      enable = true;
    };

    # Enable koofr
    koofr = {
      enable = true;
    };

    # Enable pcloud
    pcloud = {
      enable = true;
    };

    # Enable seafile
    seafile = {
      enable = true;
    };

    # Enable spideroak
    spideroak = {
      enable = true;
    };

    # Enable tresorit
    tresorit = {
      enable = true;
    };

    # Enable box
    box = {
      enable = true;
    };

    # Enable drive
    drive = {
      enable = true;
    };

    # Enable hubic
    hubic = {
      enable = true;
    };

    # Enable jottacloud
    jottacloud = {
      enable = true;
    };

    # Enable koofr
    koofr = {
      enable = true;
    };
  };
}

