{
  config,
  lib,
  pkgs,
  unstablePkgs,
  ...
}:
let
  obs-backgroundremoval-cuda = pkgs.obs-studio-plugins.obs-backgroundremoval.overrideAttrs (oldAttrs: {
    buildInputs = oldAttrs.buildInputs ++ [ pkgs.cudatoolkit ];
    cmakeFlags = (oldAttrs.cmakeFlags or []) ++ [
      "-DCUDA_TOOLKIT_ROOT_DIR=${pkgs.cudatoolkit}"
      "-DOpenCV_CUDA=ON"
    ];
  });
in
{
  programs.obs-studio.enableVirtualCamera = true;

  environment.systemPackages = [
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-livesplit-one
        obs-backgroundremoval-cuda
        obs-multi-rtmp
        #obs-vertical-canvas
        obs-text-pthread
        obs-shaderfilter
        obs-gradient-source
        obs-composite-blur
        obs-command-source
        unstablePkgs.obs-studio-plugins.advanced-scene-switcher
        obs-move-transition
      ];
    })
  ];
}
