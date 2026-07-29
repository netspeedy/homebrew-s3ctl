class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.10"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.10/s3ctl-darwin-arm64.tar.gz"
      sha256 "264bc5a5297323fe93c8936dc38de8e9cf7f03f6ef3d275a5ff1eab468e18bcc"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.10/s3ctl-darwin-amd64.tar.gz"
      sha256 "f66226e21cfde7e0365311f4b92de7b0db9d89a8a6dbb2d40dc18ac033f2435a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.10/s3ctl-linux-arm64.tar.gz"
      sha256 "183b48200964bbad41bb280c6fd2c45dd43a7864b330947513dc8881c9730a3d"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.10/s3ctl-linux-armv7.tar.gz"
      sha256 "b78a71be1e46b2ef33087342c5cee7d98a8d143141a274c0117b7267269755fa"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.10/s3ctl-linux-amd64.tar.gz"
      sha256 "9676f6a16ef819c578e279ef260fb03cd28c7c2d9f3651fba11801ab1d7a559b"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
