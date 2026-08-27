class Qc < Formula
  desc "CLI for Qumu Cloud REST API operations"
  homepage "https://github.com/qumu/qcpy"
  version "branch-main"

  on_macos do
    url "https://europe-generic.pkg.dev/qumu-dev/public/qcpy/60400302a43da9056e5ba6378caee82e04143137/qc-darwin-arm64"
    sha256 "b37f75897229cb3f52cac6a1cf4e645854fff55769b5acf3c393115982eb8461"
  end

  on_linux do
    url "https://europe-generic.pkg.dev/qumu-dev/public/qcpy/60400302a43da9056e5ba6378caee82e04143137/qc-linux-amd64"
    sha256 "aeadefc05000b47bd63c0c39f4fac8613f12a6f1c86258c47a19f4c424bdf662"
  end

  def install
    binary_name = OS.mac? ? "qc-darwin-arm64" : "qc-linux-amd64"
    bin.install binary_name => "qc"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/qc --help")
  end
end
