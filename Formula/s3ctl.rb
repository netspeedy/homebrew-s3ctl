class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.16"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.16/s3ctl-darwin-arm64.tar.gz"
      sha256 "04024e103879bf4796b3a83aff8040f9dd2ec7ed952094674163ca7ccac6789b"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.16/s3ctl-darwin-amd64.tar.gz"
      sha256 "4defd03825695f361d93cabd3e7863da9d799c385c73c513626f5db565d615d7"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.16/s3ctl-linux-arm64.tar.gz"
      sha256 "fa5c319837703c7467a68ba2daa6bc8d85ae861aad325bf66b92e0b6124e8d3c"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.16/s3ctl-linux-armv7.tar.gz"
      sha256 "25b51f88a87d551de3bd6d8c358ed9eb6e6b9439ba2caac52353a7fd29a2fb50"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.16/s3ctl-linux-amd64.tar.gz"
      sha256 "e462e8b95da747ae24e404f8b9ca15e7f0a86f78b3c6f5afd4aa0602c4214a6e"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
