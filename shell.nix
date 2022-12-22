with import <nixpkgs> {};

mkShell {
  packages = [
    umlet
    ruby_3_0
    nodejs
    postgresql
    yarn
  ];

  shellHook = ''
    bundle
    ./bin/dev
  '';
}
