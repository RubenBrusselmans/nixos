# network interfaces managed by opnsense
{
  networking.networkmanager.unmanaged = [
    "interface-name:enp6s0" # NIC, lan-opnsense (onderaan)
    "interface-name:enp7s0" # NIC, wan-opnsense (middelste)
  ];
}
