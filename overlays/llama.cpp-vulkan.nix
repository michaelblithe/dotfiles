
llama-cpp-input: final: prev: {
  llama-cpp =
    let
      # Call the llama.cpp package with Vulkan only (for framework)
      llamaBase = prev.callPackage "${llama-cpp-input}/.devops/nix/package.nix" {
        useCuda = false;
        useRocm = false;
        useVulkan = true;
        llamaVersion = llama-cpp-input.rev or llama-cpp-input.shortRev or "git";
      };
    in
    prev.symlinkJoin {
      name = "llama-cpp-with-all-binaries";
      paths = [ llamaBase ];
      postBuild = ''
        # Ensure all binaries are accessible
        for bin in ${llamaBase}/bin/*; do
          if [ ! -e "$out/bin/$(basename "$bin")" ]; then
            ln -s "$bin" "$out/bin/$(basename "$bin")"
          fi
        done
      '';
    };
}
