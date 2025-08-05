{ pkgs, inputs, ... }:
{

  imports = [
    ./hardware-configuration.nix
    ../.
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-laptop
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [
    "synaptics_usb"
  ];

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_16;

  boot.initrd.luks.devices."luks-4107fcda-ec65-4fbf-8488-1535b6d3adc2".device =
    "/dev/disk/by-uuid/4107fcda-ec65-4fbf-8488-1535b6d3adc2";

  networking.hostName = "barlow"; # Define your hostname.
  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  networking.wireless.iwd = {
    enable = true;
  };
  networking.networkmanager.wifi.backend = "iwd";
  networking.firewall.allowedTCPPorts = [
    3000
  ];

  environment.systemPackages = with pkgs; [ brightnessctl ];

  system.stateVersion = "24.11";
}
