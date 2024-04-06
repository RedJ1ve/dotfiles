{pkgs, ...}: let
  symlink = pkgs.writeShellScript "symlink" ''
    if [[ "$1" == "-r" ]]; then
      rm -rf "$HOME/.config/ags"
    fi

    if [[ "$1" == "-a" ]]; then
      rm -rf "$HOME/.config/ags"

      ln -s "$HOME/Projects/dotfiles/ags" "$HOME/.config/ags"
    fi
  '';
  nx-switch = pkgs.writeShellScriptBin "nx-switch" ''
    ${symlink} -r

    sudo alejandra .

    sudo nixos-rebuild switch --flake . --impure

    ${symlink} -a
  '';
in {
  home.packages = [nx-switch];
}
