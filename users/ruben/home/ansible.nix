{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ansible
    ansible-lint
  ];
  # ansible-lint ignores ansible.cfg vault_password_file
  home.sessionVariables = {
    ANSIBLE_VAULT_PASSWORD_FILE = "~/.config/ansible-vault/pass";
  };
}
