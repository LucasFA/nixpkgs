{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
}:

stdenv.mkDerivation rec {
  pname = "qc71_laptop";
  version = "unstable-2024-11-19";

  src = fetchFromGitHub {
    owner = "pobrn";
    repo = "qc71_laptop";
    rev = "6305ec382fb16dc835e4c62c2b6cfcdaf013a83a";
    hash = "sha256-1pgf77h2hjx4cbpf677gp42yz2h8rv2mv3nihg7d3fqplj72myix";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = kernel.makeFlags ++ [
    "VERSION=${version}"
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  installPhase = ''
    runHook preInstall
    install -D qc71_laptop.ko -t $out/lib/modules/${kernel.modDirVersion}/extra
    runHook postInstall
  '';

  meta = with lib; {
    description = "Linux driver for QC71 laptop";
    homepage = "https://github.com/pobrn/qc71_laptop/";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ aacebedo ];
    platforms = platforms.linux;
  };
}
