class Qc < Formula
  desc "CLI for Qumu Cloud REST API operations"
  homepage "https://github.com/qumu/qcpy"
  version "16ac100a6a5b09829f539cbdb68006a594b13f96"

  on_macos do
    url "https://artifactregistry.googleapis.com/download/v1/projects/qumu-dev/locations/europe/repositories/public/files/qcpy:16ac100a6a5b09829f539cbdb68006a594b13f96:qc-darwin-arm64.tar.gz:download?alt=media"
    sha256 "8fc734d9bb0b55af58d12af6f53ffe82e4d220feb855900954c6208718ab4059"
  end

  on_linux do
    url "https://artifactregistry.googleapis.com/download/v1/projects/qumu-dev/locations/europe/repositories/public/files/qcpy:16ac100a6a5b09829f539cbdb68006a594b13f96:qc-linux-amd64:download?alt=media"
    sha256 "9d4e9d40b6a656309c9e904133a8ff62a053caec3d356ea78e589dfd1b8fe248"
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
