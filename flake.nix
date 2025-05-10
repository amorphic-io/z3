{
  description = "fpga-assembler";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/2c8d3f48d33929642c1c12cd243df4cc7d2ce434";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        common = with pkgs; {
          bazel = bazel_7;
          jdk = jdk;
        };
      in
      {
        devShells.default =
          let
            # There is too much volatility between even micro-versions of
            # newer clang-format. Use slightly older version for now.
            clang_for_formatting = pkgs.llvmPackages_17.clang-tools;

            # clang tidy: use latest.
            clang_for_tidy = pkgs.llvmPackages_18.clang-tools;
          in
          with pkgs;
          pkgs.mkShell {
            packages = with pkgs; [
              git
              common.bazel
              common.jdk
              bash
              gdb

              # For clang-tidy and clang-format.
              clang_for_formatting
              clang_for_tidy

              # For buildifier, buildozer.
              bazel-buildtools
              bant

              # Profiling and sanitizers.
              linuxPackages_latest.perf
              pprof
              perf_data_converter
              valgrind
            ];

            CLANG_TIDY = "${clang_for_tidy}/bin/clang-tidy";
            CLANG_FORMAT = "${clang_for_formatting}/bin/clang-format";

            shellHook = ''
              exec bash
            '';
          };
      }
    );
}
