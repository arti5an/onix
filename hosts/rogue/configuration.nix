# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "rogue"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
    #   useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Cosmic greeter and desktop
  # services.displayManager.cosmic-greeter.enable = true;
  # services.desktopManager.cosmic.enable = true;
  # services.system76-scheduler.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" "richard"];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    richard = {
      uid = 1000;
      isNormalUser = true;
      description = "Richard";
      initialHashedPassword = "$6$YSQKtWp3CE9PMoSN$xjCl/cHEtGz0FGQ8br1LqvRxNe6hr7UoNZUnatCJGKO2UcBIvktuxc5XHVMnx29jc/EZ8I3V.uqfjAO8WPKZA0";
      extraGroups = ["networkmanager" "video" "wheel"];
    };
    artisan = {
      uid = 1024;
      isNormalUser = true;
      description = "αяτιsαη";
      extraGroups = ["networkmanager" "video" "wheel"];
      initialHashedPassword = "$6$rrPjp8wKKcN6ETsi$c6u//AGn4VujYvgeC0F9gsnJcieuOAKN/usI2qTL6qyVeZ5bBEJHPUJYjf.ZWFL56ncVoM8TGGrpNHAk8Wwm.0";
    };
  };

  programs.firefox = {
    enable = true;
    preferences = {
      "browser.startup.homepage" = "https://start.duckduckgo.com/";
      "browser.tabs.closeWindowWithLastTab" = false;
      "dom.security.https_only_mode" = true;
      "network.trr.mode" = 3;
      "network.trr.uri" = "https://security.cloudflare-dns.com/dns-query"; # Block malware
      "sidebar.position_start" = false;
      "sidebar.revamp" = true;
      "sidebar.verticalTabs" = true;
      "widget.gtk.libadwaita-colors.enabled" = false;
    };
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    chafa
    feh
    foot
    git
    imv
    mount-zip
    mpv
    neovim
    qutebrowser
    unzip
    vifm
    vim
    wget
    yt-dlp
    zip

    # sway-related
    bluetui
    grim
    mako
    slurp
    wiremix
    wl-clipboard

    # fscrypt-related
    fscrypt-experimental
    fscryptctl
  ];

  services.gnome.gnome-keyring.enable = true;
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --cmd sway --issue --time --remember --asterisks";
    };
    useTextGreeter = true;
  };
  programs = {
    light.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  };
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      font-awesome
      source-han-sans
      source-han-serif
    ];
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Source Han Serif"];
      sansSerif = ["Noto Sans" "Source Han Sans"];
    };
  };
  systemd.user.services.kanshi = {
    description = "kanshi daemon";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''${pkgs.kanshi}/bin/kanshi -c kanshi_config_file'';
    };
  };
  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];

  security.pam.enableFscrypt = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.tmux.enable = true;

  programs.river-classic.enable = true;

  # List services that you want to enable:

  hardware.bluetooth = {
    enable = true;
    settings.General = {
      Experimental = true;
      FastConnectable = true;
    };
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}
