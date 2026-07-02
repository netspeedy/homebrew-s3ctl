class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.3"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.3/s3ctl-darwin-arm64.tar.gz"
      sha256 "c9289d2943949de19650f75cc0c010cb0942282890fd216296ea9dab04b216e9"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.3/s3ctl-darwin-amd64.tar.gz"
      sha256 "74eedf01132eb44e2a44df63828af6d7327964837a9fd2233fa37751d96ca509"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.3/s3ctl-linux-arm64.tar.gz"
      sha256 "d39558fe2be3bb6072cccbebc06377f3a4e0cb9e61bdd262afe5a7853897d5b0"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.3/s3ctl-linux-armv7.tar.gz"
      sha256 "496a11326baf5b333d48f1cafe5ad481fb13eb7df08c5d5b7e28c526197248dc"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.3/s3ctl-linux-amd64.tar.gz"
      sha256 "9c09bfab1f4ad8581fea7acae2a14b7ea725a7865c784bcc6b80aa172e2f4251"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
