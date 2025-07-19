{ pkgs, ... }:

let
  agnosterTheme = pkgs.fetchFromGitHub {
    owner = "oh-my-fish";
    repo = "theme-agnoster";
    rev = "4c5518c89ebcef393ef154c9f576a52651400d27"; # pin to a commit for reproducibility
    sha256 = "sha256-OFESuesnfqhXM0aij+79kdxjp4xgCt28YwTrcwQhFMU="; # you may need to update this
  };
in {
  # Make Fish default shell
  users.defaultUserShell = pkgs.fish;

  # Install Fish globally
   programs = {
    # Configure fish shell
    fish.enable = true;
    fish.interactiveShellInit = ''
      function fish_greeting
        fastfetch
      end
    '';
  };

  environment.systemPackages = with pkgs; [
    fastfetch
  ];

  # Configure Fish to source the theme
  environment.etc."fish/conf.d/agnoster.fish".text = ''
    if test -f ${agnosterTheme}/fish_prompt.fish
      source ${agnosterTheme}/fish_prompt.fish
    end
  '';
}
