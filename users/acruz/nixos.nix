{ pkgs, ... }:

{
  users.users.acruz = {
    isNormalUser = true;
    home = "/home/acruz";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.fish;
    hashedPassword = "$6$nLuAi9T79M9EtBfA$rtx2sYMOdTK8lF5TDSVASWdbdS0etf7FWPFYX3ZhQC9.TByjKGLGp6E05LePGwi9FyPwOiHIx0Vf93rMNgrso/";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCf/2ve3OqmH0vFw8xVfqtZamT5hz3M5hAt9ixkjJPvdsr4NFS5g9zemnBiCU02BCg2TokfU/H65pz/GnMd5hiGWWDFxj5tZGiID2owUqmoM8XUxXz1RJiX0M70JqmL/cqDu4DB6+dgAo7cjvKDXCRgeNp5mAtFsRHQ6YlCT2UoBgdTh563SUx10nltF0YthOnrTH4vyuzQCN36OZQrDvHKdHOSgHELEw3SfZ5FPbGf2E1LK1vnaF8Ro604LUDDzEt0p/Q2u5PQm66U4Iyk+8QYpQfoj0Gc7rGynPx2EvrjzZEEDlDRilbVcqdVdfetXSpOh55RqvNRHJ0Mp71KxUx andre@gym"
    ];
  };

  nixpkgs.overlays = import ../../lib/overlays.nix ++ [
    (import ./vim.nix)
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/1dd99a6c91b4a6909e66d0ee69b3f31995f38851.tar.gz;
      sha256 = "1z8gx1cqd18s8zgqksjbyinwgcbndg2r6wv59c4qs24rbgcsvny9";
    }))
  ];
}
