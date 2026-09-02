class Qc < Formula
  desc "CLI for Qumu Cloud REST API operations"
  homepage "https://github.com/qumu/qcpy"
  version "7b938d3ca99bd4fda4197e424c2870bcfffd4b43"

  on_macos do
    url "https://artifactregistry.googleapis.com/download/v1/projects/qumu-dev/locations/europe/repositories/public/files/qcpy:7b938d3ca99bd4fda4197e424c2870bcfffd4b43:qc-darwin-arm64.tar.gz:download?alt=media"
    sha256 "dd0a84a8141b3f2dae8c2a5abb2222dd5abf2070b59686f888245aafb55bfaee"
  end

  on_linux do
    url "https://artifactregistry.googleapis.com/download/v1/projects/qumu-dev/locations/europe/repositories/public/files/qcpy:c2fd9f40be3437bfa1361eb255cd8a169968b981:qc-linux-amd64:download?alt=media"
    sha256 "50233219b7fa0f5fe77fd752862421feaafa349d8c3f13cc3f17fa6f9602fbf6"
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
