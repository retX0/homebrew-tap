class AmfidPatch < Formula
  desc "amfid ObjC swizzle to bypass AMFI code-signature validation (arm64, SIP-off)"
  homepage "https://github.com/retX0/amfid-swizzle"
  url "https://github.com/retX0/amfid-swizzle/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "905ef9c9e7c55517983262d8ccc07e4d1de3cf38a031e0c2b850aad3e80e9f2d"
  version "0.1.0"
  license "MIT"

  # macOS arm64 only — requires SIP disabled and root at run time
  depends_on :macos
  depends_on arch: :arm64

  def install
    system "make", "all"
    bin.install "bin/inject" => "amfid-patch"
    bin.install "bin/test_ent" => "amfid-patch-test"
  end

  def caveats
    <<~EOS
      amfid-patch requires:
        • macOS arm64 with SIP disabled  (csrutil disable)
        • root privileges at runtime

      Usage:
        sudo amfid-patch --path /path/to/your/project/
        sudo amfid-patch -v --path /path/to/project/   # verbose

      Verify with:
        amfid-patch-test   # should succeed with private entitlements
    EOS
  end

  test do
    assert_predicate bin/"amfid-patch", :exist?
  end
end
