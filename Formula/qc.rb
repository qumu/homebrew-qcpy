class Qc < Formula
  desc "CLI for Qumu Cloud REST API operations"
  homepage "https://github.com/qumu/qcpy"
  version "60400302a43da9056e5ba6378caee82e04143137"

  on_macos do
    url "https://artifactregistry.googleapis.com/download/v1/projects/qumu-dev/locations/europe/repositories/public/files/qcpy:60400302a43da9056e5ba6378caee82e04143137:qc-darwin-arm64:download?alt=media"
    sha256 "b37f75897229cb3f52cac6a1cf4e645854fff55769b5acf3c393115982eb8461"
  end

  on_linux do
    url "https://artifactregistry.googleapis.com/download/v1/projects/qumu-dev/locations/europe/repositories/public/files/qcpy:60400302a43da9056e5ba6378caee82e04143137:qc-linux-amd64:download?alt=media"
    sha256 "aeadefc05000b47bd63c0c39f4fac8613f12a6f1c86258c47a19f4c424bdf662"
  end

  def install
    expected_name = OS.mac? ? "qc-darwin-arm64" : "qc-linux-amd64"
    source = [buildpath/expected_name, buildpath/"download"].find(&:exist?)
    source ||= buildpath.children.find(&:file?)
    odie "Unable to locate downloaded qc binary in buildpath" unless source

    if source.read(256).downcase.include?("<html")
      odie "Downloaded content is HTML, not a qc binary. Verify Artifact Registry URL is publicly accessible."
    end

    chmod 0755, source
    bin.install source => "qc"
    chmod 0755, bin/"qc"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/qc --help")
  end
end
