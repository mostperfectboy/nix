{ pkgs, ... }:
{
  imports = [
    ./generated-configuration.nix
    ./..
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;

  networking.hostName = "gom"; # Define your hostname.
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [ brightnessctl ];
  services.thinkfan = {
    enable = true;
    levels = [
      [
        0
        0
        55
      ]
      [
        1
        48
        60
      ]
      [
        2
        50
        61
      ]
      [
        3
        52
        63
      ]
      [
        6
        56
        65
      ]
      [
        7
        60
        85
      ]
      [
        "level auto"
        80
        32767
      ]
    ];
  };

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  boot.extraModprobeConfig = "options thinkpad_acpi fan_control=1";

  programs.light.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    audio.enable = true;
    pulse.enable = true;
  };
  networking.firewall.allowedTCPPorts = [
    3000
    3030
  ];

  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # networking.interfaces.eth0.wakeOnLan.enable = true;
  # networking.firewall.allowedUDPPorts = [  3030 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  services.openssh.enable = true;
  hardware.graphics.enable = true;
}
