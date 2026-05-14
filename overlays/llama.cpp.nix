llama-cpp-input: final: prev: {
  llama-cpp = 
    let
      llamaBase = prev.llama-cpp.override {
        cudaSupport = true;
        rocmSupport = false;
        vulkanSupport = true;
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