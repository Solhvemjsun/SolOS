{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Solhvemjsun";
    userEmail = "solhvemjsun@github.com";
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
}
