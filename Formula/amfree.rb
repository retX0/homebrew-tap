class Amfree < Formula
  desc "amfid ObjC swizzle to bypass AMFI code-signature validation (arm64, SIP-off)"
  homepage "https://github.com/retX0/amfree"
  url "https://github.com/retX0/amfree/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "d3aff5b622dc82477d67efe045dac686726cf496fd98efce55be55668f187274"
  version "0.1.5"
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
