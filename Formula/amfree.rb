class Amfree < Formula
  desc "amfid ObjC swizzle to bypass AMFI code-signature validation (arm64, SIP-off)"
  homepage "https://github.com/retX0/amfree"
  url "https://github.com/retX0/amfree/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "a31703a89018d2cc99a7dc15900d34c6bf16835e521c865b966896763d71f1ce"
  version "0.1.1"
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
        • macOS arm64 with SIP disabled  (csrutil disable)
        • root privileges at runtime

      Usage:
        sudo amfree --path /path/to/your/project/
        sudo amfree -v --path /path/to/project/   # verbose

      Verify with:
        amfree-test   # should succeed with private entitlements
    EOS
  end

  test do
    assert_predicate bin/"amfree", :exist?
  end
end
