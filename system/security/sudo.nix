{
  security.sudo = {
    execWheelOnly = true;

    extraConfig = ''
      Defaults lecture = never # rollback results in sudo lectures after each reboot, it's somewhat useless anyway
      Defaults pwfeedback # password input feedback - makes typed password visible as asterisks
      Defaults env_keep += "EDITOR PATH DISPLAY" # variables that will be passed to the root account
      Defaults timestamp_timeout = 300 # makes sudo ask for password less often
    '';

    extraRules = [
      {
        commands =
          builtins.map (command: {
            command = "/run/current-system/sw/bin/${command}";
            options = ["NOPASSWD"];
          })
          ["poweroff" "reboot" "nixos-rebuild" "nix-env" "nh" "systemctl"];
        groups = ["wheel"];
      }
    ];
  };
}
