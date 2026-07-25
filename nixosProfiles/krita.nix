{ config, lib, pkgs, ... }:

let
  # Pin a specific release for reproducibility
  kritaAiDiffusion = pkgs.fetchzip {
    url = "https://github.com/Acly/krita-ai-diffusion/releases/download/v1.52.1/krita_ai_diffusion-1.52.1.zip";  # check latest release!
    sha256 = "sha256-0mb97q761x27iigrmabrq49h2dhmsxfck35y7haswd27kmypv7p4=";  # replace with real hash
    # You can compute the hash with nix-prefetch-url --unpack <url>
  };
in
{
  home.packages = [ pkgs.krita ];  # or rely on systemPackages

  # Place the plugin so Krita finds it
  home.file.".local/share/krita/pykrita/ai_diffusion".source = "${kritaAiDiffusion}/ai_diffusion";
  # Some releases put the desktop file at top level — adjust if needed
  home.file.".local/share/krita/pykrita/ai_diffusion.desktop".source =
    "${kritaAiDiffusion}/ai_diffusion.desktop";  # verify structure of the zip
}
