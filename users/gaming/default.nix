{ ... }:

{
  users.users.gaming = {
    isNormalUser = true;
    description = "gaming";
    extraGroups = [
      "networkmanager"
      "gamemode"
    ];
  };
}
