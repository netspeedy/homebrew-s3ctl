class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.21"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.21/s3ctl-darwin-arm64.tar.gz"
      sha256 "a34294bd069ae111686881411761b94553d14313cb3663acd6a0c1bd1c7ccf75"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.21/s3ctl-darwin-amd64.tar.gz"
      sha256 "5d71a642859d09dba82efb4d6d4b35c07db55d6f8db252444988be43d4acf8b3"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.21/s3ctl-linux-arm64.tar.gz"
      sha256 "ab1199e37a9c4f3a7f15dce06893d56a9fa5d783a628154a7250575d1a92e2b2"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.21/s3ctl-linux-armv7.tar.gz"
      sha256 "70f95e105a1438499b4aefd27cffa48b50b43dc145e6934c3fe0f3e36b981544"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.21/s3ctl-linux-amd64.tar.gz"
      sha256 "4d2d2278517740a054bdf541096060b2fecd2ad3623165b65e0adf3a277afba9"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
