class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.30"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.30/s3ctl-darwin-arm64.tar.gz"
      sha256 "af8391ad272c7d38e620951b98c10140456044b45fc0436fc7a22fc491d10b81"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.30/s3ctl-darwin-amd64.tar.gz"
      sha256 "e94275fcfb0fbc8a20717b21b5c3fcfd365c168537cbb331519b10528357a344"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.30/s3ctl-linux-arm64.tar.gz"
      sha256 "2fc37390b6ed255782a34f2825ba117afb9c0ee8400375a248037d8125e5908b"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.30/s3ctl-linux-armv7.tar.gz"
      sha256 "72292c53540f14e60565351a8a34ec610d2777d1c4b7a32de58568f9ea4b4689"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.30/s3ctl-linux-amd64.tar.gz"
      sha256 "969d218429aa9477e18b7418d03cd51b57eefd382bf7b25d4a8fec220ce8a421"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
