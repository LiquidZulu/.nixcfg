{ config, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      (python3.withPackages (ps:
        with ps; [
          pandas
          requests
          numpy
          # (buildPythonPackage rec {
          #   pname = "spleeter";
          #   version = "2.4.0";
          #   src = fetchPypi {
          #     inherit pname version;
          #     sha256 = "sha256-baY2t6ObNj/IQQmI0JPtBn0N5tzGib7SesQZ7iLpWuU=";
          #   };
          #   doCheck = false;
          #   propagatedBuildInputs = with pkgs; [
          #     # Specify dependencies
          #     ffmpeg
          #     libsndfile
          #     cmake
          #   ];
          # })
        ]))
    ];
}
