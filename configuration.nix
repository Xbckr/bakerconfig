# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports = [
      ./hardware-configuration.nix
];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

 nix.settings.experimental-features = ["nix-command" "flakes"];

nix.gc = { 
  automatic = true;
  dates = "Friday 06:07";
  options = "--delete-older-than-30d";
};

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Campo_Grande";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_MX.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."becker" = {
    isNormalUser = true;
    description = "Becker";
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };
  # Enable fingerprint support for PAM
	security.pam.services.login.fprintAuth = true;
	security.pam.services.xcreensaver.fprintAuth = true;

  # If using SDDM / KDE Plasma Lock screen specifically:
	security.pam.services.sddm.fprintAuth = true;
	security.pam.services.kde.fprintAuth = pkgs.lib.mkForce true;
 
services.undervolt = {
	enable = true;
	coreOffset = -80;   # Value in mV
	analogioOffset = -20;  # Core offset
	gpuOffset  = -5;    # Igpu Offset               
	uncoreOffset = -20; # System Agent

	p1 = { limit = 20; window = 28; };     #20W instead of 25W
  	p2 = { limit = 25; window = 0.002; };  #25W peak instead of 29W
 };

 services.thermald.enable = true; #Intel thermal management

  powerManagement.cpuFreqGovernor = "powersave"; #Intel P-State Optimization
 
  services.fprintd.enable = true;

  programs.java.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs. steam = {
enable = true;
};
  # Enable Bluetooth Hardware Support 
  hardware.bluetooth.enable = true;

  # Enable bluetooth controller automatically upon startup of system
 hardware.bluetooth.powerOnBoot = true;

 services.flatpak.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
gimp
steam
kitty
fastfetch
vim
neovim
libreoffice
vlc
vscode
krita
discord
spotify
git
home-manager
rar
unrar
fprintd
libfprint
kdePackages.bluedevil
kdePackages.bluez-qt
aircrack-ng
nmap
wireshark
metasploit
hashcat
hping
foremost
iw
mangohud
gcc
gnumake
binutils
ani-cli
gnome-chess
supertuxkart
tealdeer
xclip
];
  # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
