class Qc < Formula
  desc "CLI for Qumu Cloud REST API operations"
  homepage "https://github.com/qumu/qcpy"
  version "edf410c651d5ae53f62504d9695c4a4bf5056792"

  on_macos do
    url "https://artifactregistry.googleapis.com/download/v1/projects/qumu-dev/locations/europe/repositories/public/files/qcpy:edf410c651d5ae53f62504d9695c4a4bf5056792:qc-darwin-arm64.tar.gz:download?alt=media"
    sha256 "fb2d841c84b34c0c138d3a9f9f1b62dd6ba60757d13372c14eb1a2ccdcc6c343"
  end

  on_linux do
    url "https://artifactregistry.googleapis.com/download/v1/projects/qumu-dev/locations/europe/repositories/public/files/qcpy:592163f991a4e96152dcaeb4070fc2cae32a0f6b:qc-linux-amd64:download?alt=media"
    sha256 "9d7e3f190cf70389c256d529e2ed2bc6ba1c30902d8ec55ebfe6e732584fd477"
  end

  def install
    expected_name = OS.mac? ? "qc-darwin-arm64" : "qc-linux-amd64"
    source = [buildpath/expected_name, buildpath/"download"].find(&:exist?)
    source ||= buildpath.children.find(&:file?)
    odie "Unable to locate downloaded qc binary in buildpath" unless source

    if source.read(256).downcase.include?("<html")
      odie "Downloaded content is HTML, not a qc binary. Verify Artifact Registry URL is publicly accessible."
    end

    if OS.mac?
      mkdir libexec/expected_name do
        system "tar", "-xzf", source, "--strip-components=1", "-C", "."
      end
      chmod 0755, libexec/expected_name/expected_name
      bin.install_symlink libexec/expected_name/expected_name => "qc"
    else
      chmod 0755, source
      bin.install source => "qc"
      chmod 0755, bin/"qc"
    end
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/qc --help")
  end
end
