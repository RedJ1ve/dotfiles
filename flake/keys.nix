let
  inherit (builtins) attrValues;

  utils = {
    # helpers
    mkGlobal = list: list ++ [users.notashelf];
  };

  users = {
    # users
    aecyr = "";
  };

  machines = {
    # hosts
    amalthea = "";
  };

  # aliases
  workstations = attrValues {inherit (machines) amalthea;};
in {
  inherit (utils) mkGlobal;
  inherit (users) aecyr;
  inherit (machines) amalthea;
  inherit workstations;
}
