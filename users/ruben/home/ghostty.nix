{ ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "noctalia";
      font-family = "JetBrainsMono Nerd Font";
      shell-integration-features = "sudo,cursor,ssh-env";
      background-opacity = 0.85;
    };
  };
}
