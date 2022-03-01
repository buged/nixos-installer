#!/bin/sh

# The configuration file that will be generated.
CONF_FILE="/mnt/etc/nixos/conf/desktop.nix"

# The type of desktop to deploy.
TYPE=""

# Parse the arguments to the script.
while [ "$#" -gt 0 ]; do
  case "$1" in
    --type=*)         TYPE="${1#*=}"; shift 1;;
    *)                echo "invalid argument: $1" >&2; exit 1;;
  esac
done

# The template string for the base desktop configuration.
STR_DESKTOP="\
{config, pkgs, ...}:
{
  # The required packages for XFCE.
  environment.systemPackages = with pkgs; [
    lightdm
    lightlocker
  ];

  # Enable hardware acceleration.
  hardware.opengl.enable = true;
  
  # Configure the services required for a desktop.
  services = {
    xserver = {
      enable = true;
      layout = \"us\";
      libinput.enable = true;
      xkbOptions = "eurosign:e";

      # Make lightdm the default Display Manager and Plasma the default Desktop
      # Manager.
      displayManager = {
        lightdm.enable = true;
        defaultSession = \"plasma\";
      };

      # Enable Plasma as an available Desktop Manager.
      desktopManager = {
        plasma5.enable = true;
      };
    };
  };
}"

STR_DESKTOP_EMPTY="\
{ config, pkgs, ... }:
{
}"

if [ "${TYPE}" == "desktop" ]; then
  echo "${STR_DESKTOP}" > ${CONF_FILE}
else
  echo "${STR_DESKTOP_EMPTY}" > ${CONF_FILE}
fi
