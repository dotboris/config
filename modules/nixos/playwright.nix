{...}: {
  # Playwright downloads a bunch of binaries (chrome & co) from the internet.
  # These binaries expect a standard linux environment with a libraries and a
  # loader. NixOS doesn't have that. So we set that up here.
  flake.nixosModules.playwright = {
    pkgs,
    lib,
    ...
  }: {
    programs.nix-ld = {
      enable = true;
      libraries = [
        pkgs.alsa-lib
        pkgs.at-spi2-atk
        pkgs.atk
        pkgs.cairo
        pkgs.cups
        pkgs.dbus
        pkgs.expat
        pkgs.glib
        pkgs.gobject-introspection
        pkgs.libgbm
        pkgs.libgcc
        pkgs.libxkbcommon
        pkgs.nspr
        pkgs.nss
        pkgs.pango
        pkgs.stdenv.cc.cc.lib
        pkgs.systemd
        pkgs.libx11
        pkgs.libxcomposite
        pkgs.libxdamage
        pkgs.libxext
        pkgs.libxfixes
        pkgs.libxrandr
        pkgs.libxcb
      ];
    };
  };
}
