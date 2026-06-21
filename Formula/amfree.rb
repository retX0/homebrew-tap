class Amfree < Formula
  desc "Amfid ObjC swizzle to bypass AMFI code-signature validation (arm64, SIP-off)"
  homepage "https://github.com/retX0/amfree"
  url "https://github.com/retX0/amfree/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "c6e03c17c99970346d123c1f690818b51f5030e8dc7c1f4c760b8138274e954d"
  license "MIT"

  # macOS arm64 only — requires SIP disabled and root at run time
  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system "make", "all", "GIT_VER=v#{version}"
    bin.install "bin/amfree"
  end

  def caveats
    <<~EOS
      amfree requires:
        • macOS 26.0 or newer on arm64
        • macOS arm64 with SIP debug disabled  (csrutil enable --without debug)
        • root privileges at runtime

      macOS versions older than 26.0 are not supported.

      Usage:
        sudo amfree --path /path/to/your/project/
        sudo amfree --path /path/one/ --path /path/two/   # multiple dirs
        sudo amfree -v --path /path/to/project/           # verbose
        sudo amfree --list                                 # list watched paths
        sudo amfree --hook-verbose on                      # enable hook logging
        sudo amfree --hook-verbose off                     # disable hook logging
    EOS
  end

  test do
    assert_path_exists bin/"amfree"
  end
end
