class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.29"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.29/s3ctl-darwin-arm64.tar.gz"
      sha256 "791c63412f6819e3b7b4cad620ec11daba324dd26b427cccb95c42e1d76dcde5"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.29/s3ctl-darwin-amd64.tar.gz"
      sha256 "3f4222837477a29a27f4794c40b4256bc0af66861d4d5490494ccc82b1294f3a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.29/s3ctl-linux-arm64.tar.gz"
      sha256 "d3cf25ea1d21efc4925c615eece277f85dec82bba4d08e25d1785af501a48745"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.29/s3ctl-linux-armv7.tar.gz"
      sha256 "79e4ca7edc0c8621424b66c7eb22f0bf67d6f760aa8db6e8d6df7922677a63f3"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.29/s3ctl-linux-amd64.tar.gz"
      sha256 "33c03edae884337d556c1ad225af2aaeb84bfcbc8ee2194acfd01e305827fe50"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
