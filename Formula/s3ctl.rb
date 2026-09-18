class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.28"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.28/s3ctl-darwin-arm64.tar.gz"
      sha256 "5065da81f61232856accd2e99e9202a252690e29abadc6bf7bfae3f128e36c5b"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.28/s3ctl-darwin-amd64.tar.gz"
      sha256 "5b159b1c48394bc7e1442fa978ea4732e7930c708b4b02a885e931db47e1d295"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.28/s3ctl-linux-arm64.tar.gz"
      sha256 "521ac871cb86f26d8c60634ccdbfcf658fbf80f2a63bbe442c9bc18bb6f936f1"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.28/s3ctl-linux-armv7.tar.gz"
      sha256 "ba38d7974d9fbfc160cc315877c6935801f6ad69aa1bd36531c90a1b42a4e4e3"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.28/s3ctl-linux-amd64.tar.gz"
      sha256 "f75ee3e920c018cadfe8f2f7c66dadbaff94bdf1c769bd55ac016f09884f9562"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
