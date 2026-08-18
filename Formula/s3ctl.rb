class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.18"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.18/s3ctl-darwin-arm64.tar.gz"
      sha256 "0db234fb9f1047b474258b1b2bf2e1d25d34aba8f3e07909a02b6c7704542af1"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.18/s3ctl-darwin-amd64.tar.gz"
      sha256 "c309dcb1c5cbb3e8bd1a449a5bb5d035f90d631112d1b45dfc58d2a2cd86bb56"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.18/s3ctl-linux-arm64.tar.gz"
      sha256 "980c8289259283711ef5fb81d810d8cae533bcb205bd300472394492f7742b00"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.18/s3ctl-linux-armv7.tar.gz"
      sha256 "d73bcbf2f4995b5c2269808fe9c121736fd8890b0004aae248a2013e55036d08"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.18/s3ctl-linux-amd64.tar.gz"
      sha256 "8bbf862af52bb788804a49afecaf0e088b441d497af1d21ad12e6e50577bfdcf"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
