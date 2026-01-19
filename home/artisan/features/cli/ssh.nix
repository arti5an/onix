{
  programs.ssh.matchBlocks = {
    homelab = {
      host = "jarvis ultron";
      extraOptions = {
        canonicalizeHostname = "yes";
        canonicalDomain = "home";
      };
    };
    homenet = {
      host = "*.home";
      extraOptions = {
        visualHostKey = "yes";
      };
    };
  };
}
