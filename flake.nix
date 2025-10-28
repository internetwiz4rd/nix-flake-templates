{
  description = "A collection of internet_wizard's opinionated nix flake templates";

  outputs = {self}: {
    templates = {
      flake-template = {
        path = ./flake-template;
        description = "A very basic, opinionated flake";
      };

      rust = {
        path = ./rust;
        description = "A rust development flake that adds the necessary tooling and development environment for excellent automation";
      };
    };

    defaultTemplate = self.templates.flake-template;
  };
}
