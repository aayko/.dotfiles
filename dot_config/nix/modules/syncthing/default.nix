{ config, lib, ... }:

let
  cfg = config.mynix;
  folderConfig = path: {
    path = path;
    versioning = {
      type = "simple";
      params = {
        keep = "5";
      };
    };

    devices = [ "server" ];
  };
in
{
  options = {
    mynix.syncthing.enable = lib.mkEnableOption "Setup syncthing";
  };

  config = lib.mkIf cfg.syncthing.enable {
    programs.fuse.userAllowOther = true;

    services.syncthing = rec {
      enable = true;
      user = "ayko";
      dataDir = "/home/ayko";
      configDir = "${dataDir}/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        devices = {
          "server" = { id = "26UF5VN-VZOLOS5-5XVDBFP-O3U5L7N-BLVSNOH-BSERUSX-X7M6IZA-CPUHSA6"; };
        };
        folders = {
          "documents" = folderConfig "${dataDir}/documents";
          "uni" = folderConfig "${dataDir}/uni";
          "pictures" = folderConfig "${dataDir}/pictures";
          "ds" = folderConfig "${dataDir}/games/ds";
          "key" = folderConfig "${dataDir}/.age";
          "notes" = folderConfig "${dataDir}/notes";
          "perso" = folderConfig "${dataDir}/perso";
          "photos" = folderConfig "${dataDir}/photos";
        };
      };
    };
  };
}
