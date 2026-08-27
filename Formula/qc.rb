class Qc < Formula
  desc "CLI for Qumu Cloud REST API operations"
  homepage "https://github.com/qumu/qcpy"
  version "60400302a43da9056e5ba6378caee82e04143137"

  on_macos do
    url "https://europe-generic.pkg.dev/qumu-dev/public/qcpy/60400302a43da9056e5ba6378caee82e04143137/qc-darwin-arm64"
    sha256 "507682142f02c071159f22877d770551975d9c4746717c42837bac166c857cae"
  end

  on_linux do
    url "https://europe-generic.pkg.dev/qumu-dev/public/qcpy/60400302a43da9056e5ba6378caee82e04143137/qc-linux-amd64"
    sha256 "aeadefc05000b47bd63c0c39f4fac8613f12a6f1c86258c47a19f4c424bdf662"
  end

  def install
    expected_name = OS.mac? ? "qc-darwin-arm64" : "qc-linux-amd64"
    source = [buildpath/expected_name, buildpath/"download"].find(&:exist?)
    source ||= buildpath.children.find(&:file?)
    odie "Unable to locate downloaded qc binary in buildpath" unless source

    chmod 0755, source
    bin.install source => "qc"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/qc --help")
  end
end
