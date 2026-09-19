{ ... }:
{
  console.keyMap = "be-latin1";

  services.xserver.xkb = {
    layout = "be";
    variant = "";
  };
}
