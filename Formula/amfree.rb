class Amfree < Formula
  desc "amfid ObjC swizzle to bypass AMFI code-signature validation (arm64, SIP-off)"
  homepage "https://github.com/retX0/amfree"
  url "https://github.com/retX0/amfree/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "81a2814b1dd65821dfe84591b29db51b455af94686cac057451b9bf6581cab10"
  version "0.1.4"
  license "MIT"

  # macOS arm64 only — requires SIP disabled and root at run time
  depends_on :macos
  depends_on arch: :arm64

  def install
    system "make", "all"
    bin.install "bin/amfree"
  end

  def caveats
    <<~EOS
      amfree requires:
        • macOS arm64 with SIP debug disabled  (csrutil enable --without debug)
        • root privileges at runtime

      Usage:
        sudo amfree --path /path/to/your/project/
        sudo amfree -v --path /path/to/project/   # verbose
        sudo amfree --list                         # list watched paths
    EOS
  end

  test do
    assert_predicate bin/"amfree", :exist?
  end
end
