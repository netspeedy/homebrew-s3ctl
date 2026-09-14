class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.26"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.26/s3ctl-darwin-arm64.tar.gz"
      sha256 "79914de6337726130cd72267bfaeca7b60287170d8abe8cff15ba15cbed10598"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.26/s3ctl-darwin-amd64.tar.gz"
      sha256 "10d58cb1360b01149dc50591a11fc6d6cbd4e0481e73077022d96055d4a5b855"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.26/s3ctl-linux-arm64.tar.gz"
      sha256 "f690771a6518f2514426311646e5581d36d3c94436f371b8143638931003ce8a"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.26/s3ctl-linux-armv7.tar.gz"
      sha256 "e1c645e168972dc7d7028891129e78205c86c0f21c1afd2a0af014d0ac0a0885"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.26/s3ctl-linux-amd64.tar.gz"
      sha256 "ee3d2143d8bdc4ff26424616037342641959318488af7f58f3d396e45c06b00d"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
