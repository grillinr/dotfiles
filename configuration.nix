{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone
  time.timeZone = "America/New_York";

  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "us";

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable sound with pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager, but not always)
  services.xserver.libinput.enable = true;

  # Define a user account
  users.users.nathan = {
    isNormalUser = true;
    description = "Nathan";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "input" "tty" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Core system
    vim
    wget
    curl
    git
    unzip
    htop
    btop
    tree
    file
    which
    man-pages
    man-pages-posix

    # Development tools
    gcc
    gnumake
    cmake
    go
    nodejs
    npm
    python3
    python3Packages.pip
    rustc
    cargo
    rust-analyzer
    typescript

    # System utilities
    acpi
    brightnessctl
    btrfs-progs
    efibootmgr
    inxi
    smartmontools
    traceroute
    wireless_tools
    zram-generator

    # Audio/Video
    alsa-utils
    pavucontrol
    pamixer
    mpv
    ffmpegthumbnailer
    imagemagick

    # Network
    iwd
    networkmanagerapplet

    # File management
    thunar
    thunar-archive-plugin
    thunar-volman
    file-roller
    tumbler

    # Desktop environment
    waybar
    rofi-wayland
    swaynotificationcenter
    wlogout
    wofi
    kitty
    neovim
    fastfetch
    eza
    fzf
    lazygit
    onefetch

    # Hyprland ecosystem
  hyprland
  hypridle
    hyprlock
    hyprpaper
    hyprpicker
    hyprshot
    swww
    slurp
    grim
    swappy
    wl-clipboard
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland

    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "CascadiaCode" "Hack" "Iosevka" "SourceCodePro" "UbuntuMono" "DroidSansMono" "DejaVuSansMono" "LiberationMono" "Noto" "Overpass" "GeistMono" "CommitMono" "Monaspace" "Hermit" "Hasklig" "Agave" "AnonymousPro" "Arimo" "BigBlueTerminal" "BitstreamVeraSansMono" "CascadiaMono" "Cousine" "D2Coding" "DaddyTimeMono" "EnvyCodeR" "FantasqueSansMono" "GoMono" "Gohu" "HeavyData" "IAWriter" "IBMPlexMono" "Inconsolata" "InconsolataGo" "InconsolataLGC" "Intone" "IosevkaTerm" "IosevkaTermSlab" "JetBrainsMono" "Lekton" "LiberationMono" "Lilex" "MartianMono" "Meslo" "Monofur" "Monoid" "Mononoki" "MPlus" "ProFont" "ProggyClean" "Recursive" "RobotoMono" "ShareTechMono" "SpaceMono" "Terminus" "Tinos" "VictorMono" "ZedMono" ]; })

    # GTK themes
    adapta-gtk-theme
    arc-gtk-theme
    gtk-engine-murrine

    # Applications
    firefox
    discord
    spotify
    libreoffice
    qalculate-gtk
    yad

    # Power management
    tlp
    auto-cpufreq
    powertop

    # Other utilities
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

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "CascadiaCode" "Hack" "Iosevka" "SourceCodePro" "UbuntuMono" "DroidSansMono" "DejaVuSansMono" "LiberationMono" "Noto" "Overpass" "GeistMono" "CommitMono" "Monaspace" "Hermit" "Hasklig" "Agave" "AnonymousPro" "Arimo" "BigBlueTerminal" "BitstreamVeraSansMono" "CascadiaMono" "Cousine" "D2Coding" "DaddyTimeMono" "EnvyCodeR" "FantasqueSansMono" "GoMono" "Gohu" "HeavyData" "IAWriter" "IBMPlexMono" "Inconsolata" "InconsolataGo" "InconsolataLGC" "Intone" "IosevkaTerm" "IosevkaTermSlab" "JetBrainsMono" "Lekton" "LiberationMono" "Lilex" "MartianMono" "Meslo" "Monofur" "Monoid" "Mononoki" "MPlus" "ProFont" "ProggyClean" "Recursive" "RobotoMono" "ShareTechMono" "SpaceMono" "Terminus" "Tinos" "VictorMono" "ZedMono" ]; })
    noto-fonts
    noto-fonts-emoji
    font-awesome
    liberation_ttf
    fira-code
    fira-code-symbols
    dina-font
    proggyfonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

  # Open ports in the firewall
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.05";

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Auto garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Enable hardware acceleration
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # NVIDIA support (uncomment if you have NVIDIA GPU)
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   powerManagement.enable = false;
  #   open = false;
  #   nvidiaSettings = true;
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  # };

  # Enable TLP for power management
  services.tlp.enable = true;

  # Enable auto-cpufreq
  services.auto-cpufreq.enable = true;

  # Enable zram
  zramSwap.enable = true;
  zramSwap.memoryPercent = 50;

  # Enable snapd
  services.snapd.enable = true;

  # Enable flatpak
  services.flatpak.enable = true;

  # Enable timeshift
  services.timeshift.enable = true;

  # Enable onedrive
  services.onedrive.enable = true;

  # Enable gvfs
  services.gvfs.enable = true;

  # Enable udisks2
  services.udisks2.enable = true;

  # Enable devmon
  services.devmon.enable = true;

  # Enable upower
  services.upower.enable = true;

  # Enable power-profiles-daemon
  services.power-profiles-daemon.enable = true;

  # Enable thermald
  services.thermald.enable = true;

  # Enable fstrim
  services.fstrim.enable = true;

  # Enable earlyoom
  services.earlyoom.enable = true;

  # Enable logind
  services.logind = {
    extraConfig = ''
      HandleLidSwitch=suspend
      HandleLidSwitchExternalPower=suspend
      HandleLidSwitchDocked=ignore
    '';
  };

  # Enable systemd-resolved
  services.resolved.enable = true;

  # Enable systemd-timesyncd
  services.timesyncd.enable = true;

  # Enable systemd-networkd
  systemd.network.enable = true;

  # Enable systemd-user-sessions
  services.systemd-user-sessions.enable = true;

  # Enable systemd-journald
  services.journald.enable = true;

  # Enable systemd-logind
  services.logind.enable = true;

  # Enable systemd-udevd
  services.udev.enable = true;

  # Enable systemd-tmpfiles
  systemd.tmpfiles.enable = true;

  # Enable systemd-boot
  systemd.boot.enable = true;

  # Enable systemd-networkd-wait-online
  systemd.network.wait-online.enable = true;

  # Enable systemd-resolved
  systemd.resolved.enable = true;

  # Enable systemd-timesyncd
  systemd.timesyncd.enable = true;

  # Enable systemd-user-sessions
  systemd.user-sessions.enable = true;

  # Enable systemd-journald
  systemd.journald.enable = true;

  # Enable systemd-logind
  systemd.logind.enable = true;

  # Enable systemd-udevd
  systemd.udevd.enable = true;

  # Enable systemd-tmpfiles
  systemd.tmpfiles.enable = true;

  # Enable systemd-boot
  systemd.boot.enable = true;

  # Enable systemd-networkd-wait-online
  systemd.network.wait-online.enable = true;
}

