class Amfree < Formula
  desc "amfid ObjC swizzle to bypass AMFI code-signature validation (arm64, SIP-off)"
  homepage "https://github.com/retX0/amfree"
  url "https://github.com/retX0/amfree/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "233485d5b07afcb4cf1b343d19f9f70c33df92c0645c5eb732aa4ead43793679"
  version "0.1.3"
  license "MIT"

  # macOS arm64 only — requires SIP disabled and root at run time
  depends_on :macos
  depends_on arch: :arm64

  def install
    system "make", "all"
    bin.install "bin/amfree"
    bin.install "bin/test_ent" => "amfree-test"
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

      Verify with:
        amfree-test   # should succeed with private entitlements
    EOS
  end

  test do
    assert_predicate bin/"amfree", :exist?
  end
end
