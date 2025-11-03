{
  description = "A collection of of-the-star's opinionated nix flake templates";

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

      python = {
        path = ./python;
        description = "A python development flake";
      };
    };

    templates.default = self.templates.flake-template;
  };
}
