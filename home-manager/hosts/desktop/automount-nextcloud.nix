{...}: {
  systemd.user.services.automout-nextcloud = {
    Install.WantedBy = ["default.target"];
    Unit.Description = "Automatically mount Nextcloud files";
    Service = {
      Type = "oneshot";
      # Note: we're using the global `gio` because using the one in `nixpkgs`
      # doesn't work. It doesn't find any of the volumes defined for the system.
      ExecStart = "gio mount -d davs://dotboris@cloud.dotboris.io/remote.php/webdav";

      # Because we're a user unit, we can't tell systemd that we want to start
      # after `network-online.target`. That unit exists at the system level but
      # not at the user level. Instead, we just keep retrying.
      Restart = "on-failure";
      RestartSec = "5s";
      RestartSteps = 0; # Restart forever
    };
  };
}
