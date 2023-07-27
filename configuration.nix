# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

# This adds a cgit server to be a remote server for Git repositories: https://terinstock.com/post/2021/01/Setting-up-a-git-server-on-NixOS/
#let
#  cgit = pkgs.cgit;
#  cgitConfig = pkgs.writeText "cgitrc" (lib.generators.toKeyValue { } {
#    css = "${cgit}/cgit.css";
#    logo = "${cgit}/cgit.png";
#    favicon = "/favicon.ico";
#    about-filter = "${cgit}/lib/cgit/filters/about-formatting.sh";
#    source-filter = "${cgit}/lib/cgit/filters/syntax-highlighting.py";
#    clone-url = (lib.concatStringsSep " " [
#      "https://$HTTP_HOST$SCRIPT_NAME/$CGIT_REPO_URL"
#      "ssh://git@git.t.com:$CGIT_REPO_URL"
#    ]);
#    enable-log-filecount = 1;
#    enable-log-linecount = 1;
#    enable-git-config = 1;
#    root-title = "git.t.com";
#    root-desc = "Tom's Git Repositories";
#    scan-path = "/srv/git";
#  });
#  h2oFile = file: {
#    "file.file" = "${file}";
#    "file.send-compressed" = "ON";
#  };
#  h2oHeaderList = attrs: (lib.mapAttrsToList (k: v: "${k}: ${v}") attrs);
#  h2oConfig = pkgs.writeText "h2o.conf" (lib.generators.toYAML { } {
#    hosts."git.terinstock.com" = {
#      paths = {
#        "/cgit.css" = h2oFile "${cgit}/cgit/cgit.css";
#        "/cgit.png" = h2oFile "${cgit}/cgit/cgit.png";
#        "/favicon.ico" = h2oFile "${cgit}/cgit/favicon.ico";
#        "/robots.txt" = h2oFile "${cgit}/cgit/robots.txt";
#        "/" = {
#          "fastcgi.spawn" = "${pkgs.h2o}/share/h2o/fastcgi-cgi";
#          setenv = {
#            SCRIPT_FILENAME = "${cgit}/cgit/cgit.cgi";
#            CGIT_CONFIG = "${cgitConfig}";
#          };
#          compress = "ON";
#        };
#      };
#      "header.set" = {
#        header = (h2oHeaderList {
#          x-frame-options = "deny";
#          x-xss-protection = "1, mode=block";
#          x-content-type-options = "nosniff";
#          referrer-policy = "no-referrer, strict-origin-when-cross-origin";
#          cache-control = "no-transform";
#          strict-transport-security = "max-age=63072000";
#          content-security-policy = (lib.concatStringsSep "; " [
#            "default-src 'none'"
#            "style-src 'self' 'unsafe-inline'"
#            "img-src 'self' data: https://img.shields.io"
#            "script-src-attr 'unsafe-inline'"
#          ]);
#          expect-ct = "enforce, max-age=30";
#        });
#      };
#      listen = {
#        port = 443;
#        ssl = {
#          certificate-file = "/var/lib/acme/git.terinstock.com/fullchain.pem";
#          key-file = "/var/lib/acme/git.terinstock.com/key.pem";
#          min-version = "TLSv1.2";
#          cipher-preference = "server";
#          cipher-suite = (lib.concatStringsSep ":" [
#            "TLS_AES_128_GCM_SHA256"
#            "TLS_AES_256_GCM_SHA384"
#            "TLS_CHACHA20_POLY1305_SHA256"
#            "ECDHE-ECDSA-AES128-GCM-SHA256"
#            "ECDHE-RSA-AES128-GCM-SHA256"
#            "ECDHE-ECDSA-AES256-GCM-SHA384"
#            "ECDHE-RSA-AES256-GCM-SHA384"
#            "ECDHE-ECDSA-CHACHA20-POLY1305"
#            "ECDHE-RSA-CHACHA20-POLY1305"
#            "DHE-RSA-AES128-GCM-SHA256"
#            "DHE-RSA-AES256-GCM-SHA384"
#          ]);
#        };
#      };
#    };
#  });
#in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
   # no need to redefine it in your config for now)
    # media-session.enable = true;
  };


  #security.acme = {
  #  # Set to true if you agree to your ACME server's Terms of Service.
  #  # For Let's Encrypt: https://letsencrypt.org/repository/
  #  acceptTerms = true; 
  #  email = "terinjokes@gmail.com";
  #  certs = {
  #    "git.terinstock.com" = {
  #      dnsProvider = "cloudflare";
  #      credentialsFile = "/var/lib/secrets/cloudflare.secret";
  #      group = "h2o";
  #    };
  #  };
  #};

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tombrumbaugh = {
    isNormalUser = true;
    description = "tombrumbaugh";
    extraGroups = [ "networkmanager" "wheel" ];
    #packages = with pkgs; [
    #  firefox
    #  # thunderbird
    #];
  };

  # Definition for a git user account to hold my git repositories from: https://terinstock.com/post/2021/01/Setting-up-a-git-server-on-NixOS/
  # added git-shell-commands from https://github.com/git-utilities/git-shell-commands to /srv/git/
  # added modules argument parser from https://github.com/bash-utilities/argument-parser and trap failure from https://github.com/bash-utilities/trap-failure into the shared_functions directory
  users.users.git = {
    isSystemUser = true;
    description = "git user";
    home = "/srv/git";
    #extraGroups = [ ];
    group = "git";
    shell = "${pkgs.git}/bin/git-shell";
    #openssh.authorizedKeys.keys = [
    #  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIINNSIl3/j3KqW/x3kFj1ZvZlSxp+MDhk8LAIDlqs/9w"
    #];
  };

  #users.users.h2o = {
  #  group = "h2o";
  #  home = "/var/lib/h2o";
  #  createHome = true;
  #  isSystemUser = true;
  #};

  users.groups.git = { };
  #users.groups.h2o = { };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #accessdb
    #aconnect
    #addpart
    #advtest
    #agetty
    #alias
    #_allowed_groups
    #_allowed_users
    #alsabat
    #alsabat-test.sh
    #alsaconf
    #alsactl
    #alsa-info
    #alsaloop
    #alsamixer
    #alsatplg
    #alsaucm
    #amidi
    #amixer
    #amptest
    #amuFormat.sh
    #aplay
    #aplaymidi
    #apropos
    #arecord
    #arecordmidi
    #arp
    #arpd
    #arping
    #arptables
    #arptables-nft
    #arptables-nft-restore
    #arptables-nft-save
    #arptables-restore
    #arptables-save
    artha # thesaurus
    #aseqdump
    #aseqnet
    #attr
    #avahi-autoipd
    #avahi-browse
    #avahi-browse-domains
    #avahi-daemon
    #avahi-dnsconfd
    #avahi-publish
    #avahi-publish-address
    #avahi-publish-service
    #avahi-resolve
    #avahi-resolve-address
    #avahi-resolve-host-name
    #avahi-set-host-name
    #_available_interfaces
    #avinfo
    #avtest
    #awk
    #axfer
    
    blueman # bluetooth
    bluez 
    cups-pdf-to-pdf # printing library
    firefox
    home-manager
    git 
    gtk3
    locale
    most # linux terminal pager
    neofetch # commandline os display
    openssh # open source secure shell for remote login 
    # tinyssh # secure shell server
    powerline-fonts
    svkbd
    vim # vim text editor
    volumeicon # volume slider
    wget
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
 
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?


  #systemd.services.h2o = {
  #  description = "H2O web server";
  #  after = [ "network-online.target" "acme-git.terinstock.com.service" ];
  #  wantedBy = [ "multi-user.target" ];
  #  path = [ pkgs.perl pkgs.openssl ];
  #  serviceConfig = {
  #    ExecStart = "${pkgs.h2o}/bin/h2o --mode master --conf ${h2oConfig}";
  #    ExecReload = "${pkgs.coreutils}/bin/kill -s HUP $MAINPID";
  #    ExecStop = "${pkgs.coreutils}/bin/kill -s QUIT $MAINPID";
  #    User = "h2o";
  #    Group = "h2o";
  #    Type = "simple";
  #    Restart = "on-failure";
  #    AmbientCapabilities = "cap_net_bind_service";
  #    CapabilitiesBoundingSet = "cap_net_bind_service";
  #    NoNewPrivileges = true;
  #    LimitNPROC = 64;
  #    LimitNOFILE = 1048576;
  #    PrivateDevices = true;
  #    PrivetTmp = true;
  #    ProtectHome = true;
  #    ProtectSystem = "full";
  #    ReadOnlyPaths = "/var/lib/acme/";
  #    ReadWriteDirectories = "/var/lib/h2o";
  #  };
  #};


  #services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  
  # for a WiFi printer
  services.avahi.openFirewall = true;

}
