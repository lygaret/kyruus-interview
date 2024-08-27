{
  inputs = rec {
    nixpkgs.url = "github:NixOS/nixpkgs/24.11-pre";
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      ruby = pkgs.ruby_3_1.withPackages (rpkgs: with rpkgs; [ruby-lsp]);
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          ruby
          foreman

          postgresql
          redis
          yarn
          nodejs_22

          libyaml
        ];
      };
    };
}
