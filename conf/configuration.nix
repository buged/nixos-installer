# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# https://nixos.org/manual/nixos/stable/options.html

{ config, pkgs, ... }:
{
  imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./conf/fs.nix

    ./conf/desktop.nix
    ./conf/guest.nix
    ./conf/maintenance.nix
    ./conf/network.nix
    ./conf/users.nix
  ];
  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Install the default packages.
  environment.systemPackages = with pkgs; [
    vim_configurable
    wget
    htop
    git
    firefox
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}

