class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.13"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.13/s3ctl-darwin-arm64.tar.gz"
      sha256 "9f5f7c60f2e8efdc8bde073d39bbb504cf9c406111c3c0f5e3152939d9a26a07"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.13/s3ctl-darwin-amd64.tar.gz"
      sha256 "47a6e06a05372be98bf02017a36b3ad1ccbc78371696c8710fbc32f9e005e91e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.13/s3ctl-linux-arm64.tar.gz"
      sha256 "989dbf793d7aca2f68a1d6f9614d5a3caddebb13558ade55002ed6f2763df627"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.13/s3ctl-linux-armv7.tar.gz"
      sha256 "0f030e24c692531009f5722e95aef7c6ee0ffd2dd01527653930a7e16a8c0ec0"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.13/s3ctl-linux-amd64.tar.gz"
      sha256 "72c363bc1dfff837b7c5d7e934136dae12a7675c748758dd0d2ab2a3618d4ce9"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
