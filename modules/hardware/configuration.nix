{ pkgs, ... } : {

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;
  boot.kernelPackages = pkgs.linuxPackages_6_8;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  programs.light.enable = true;

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    audio.enable = true;
    pulse.enable = true;
  };
  networking.firewall.allowedTCPPorts = [ 3030 ];
  # networking.firewall.allowedUDPPorts = [  3030 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  services.openssh.enable = true;
  hardware.graphics.enable = true;
}