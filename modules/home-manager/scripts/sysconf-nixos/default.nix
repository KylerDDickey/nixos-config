{ outputs, pkgs, ... }:
let
  rootPath = outputs.meta.rootPath;
  selectedHost = outputs.meta.selectedHost;
in
{
  channels-update = pkgs.writeShellApplication {
    name = "sysconf-nixos-channels-update";
    runtimeInputs = with pkgs; [
      coreutils
      nix
      gawk
    ];
    text = ''
      CONFIG_REPO_LOCATION=${rootPath}
      FLAKE_FILE_NAME="$CONFIG_REPO_LOCATION/flake.lock"

      hash_lock_file () {
        md5sum "$FLAKE_FILE_NAME" | awk '{print $1}';
      }

      echo "Hashing lock file"
      ORIGNAL_FILE_HASH=$(hash_lock_file)
      echo "Hash: $ORIGNAL_FILE_HASH"

      echo "Updating Nix Channels"
      nix flake update --flake $CONFIG_REPO_LOCATION;

      echo "Checking new lock hash"
      NEW_FILE_HASH=$(hash_lock_file)
      echo "Hash: $NEW_FILE_HASH"

      if [ "$ORIGNAL_FILE_HASH" = "$NEW_FILE_HASH" ]; then
        echo "No changes to lock file, there have been no changes to the input channels. No action needed."
      else
        echo "Lock file hash changed. DO NOT FORGET TO COMMIT THESE CHANGES TO REMOTE!!!"
      fi
    '';
  };

  rebuild-switch = pkgs.writeShellApplication {
    name = "sysconf-nixos-rebuild-switch";
    runtimeInputs = with pkgs; [
      coreutils
      nixos-rebuild
    ];
    text = ''
      rebuild () {
        HOST=${selectedHost}
        FLAKE=${rootPath}\#$HOST
        nixos-rebuild switch --flake $FLAKE
      }

      echo "Rebuilding requires elevated permissions."
      SUDO_FUNC=$(declare -f rebuild)
      sudo -- bash -c "$SUDO_FUNC; rebuild;"

      # NO COMMANDS HERE, ALL ELEVATED COMMANDS SHOULD GO IN THE CRITICAL FUNCTION(S)

      sudo -k
      echo "Rebuild complete! Elevated permissions have been revoked."
    '';
  };
}
