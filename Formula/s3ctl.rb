class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.39"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.39/s3ctl-darwin-arm64.tar.gz"
      sha256 "558540c46d85c5e795ee65b11e2c87a8143ed7bdb3da7ac2467b1aaf61ca6379"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.39/s3ctl-darwin-amd64.tar.gz"
      sha256 "478270aed2db32f8c140c6e49565b1844affcb061c5673b4a34624a94225b867"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.39/s3ctl-linux-arm64.tar.gz"
      sha256 "b95a2776e3b257a7e71588868c545843a79f657d8f54b96faa41bc5892abda3d"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.39/s3ctl-linux-armv7.tar.gz"
      sha256 "f75e03fa82f89f0cfc552bb1b2b5f2af6eacc7a36c270f487b2dcccb697791ac"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.39/s3ctl-linux-amd64.tar.gz"
      sha256 "27b82c29e6f0fed5dc67ab60694b58159739f58d3e6e4d38cf1b5260caf796b8"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
