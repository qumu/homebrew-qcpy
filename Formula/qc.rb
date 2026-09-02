class Qc < Formula
  desc "CLI for Qumu Cloud REST API operations"
  homepage "https://github.com/qumu/qcpy"
  version "592163f991a4e96152dcaeb4070fc2cae32a0f6b"

  on_macos do
    url "https://artifactregistry.googleapis.com/download/v1/projects/qumu-dev/locations/europe/repositories/public/files/qcpy:592163f991a4e96152dcaeb4070fc2cae32a0f6b:qc-darwin-arm64.tar.gz:download?alt=media"
    sha256 "8d874702105def5bbd9cbe18b7372bc382f4580ac89fbf73d2fddc5b2734229f"
  end

  on_linux do
    url "https://artifactregistry.googleapis.com/download/v1/projects/qumu-dev/locations/europe/repositories/public/files/qcpy:3979eeb2f9b404c9d9c4dd50d39b1d599d22e057:qc-linux-amd64:download?alt=media"
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
