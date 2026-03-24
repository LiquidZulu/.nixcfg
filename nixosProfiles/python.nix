{ config, lib, pkgs, ... }: {

  environment.systemPackages = with pkgs;
    [
      python315
      # (python315.override {
      #   packageOverrides = self: super: {
      #     torch = super.torch.overridePythonAttrs (old: {
      #       env = old.env // { USE_FLASH_ATTENTION = "0"; };
      #     });
      #   };
      # })
      #python314Full
      #python310Full
      #(python310.withPackages
      #  (ps: with ps; [ torch torchvision torchaudio-bin numpy ]))
    ];
}
