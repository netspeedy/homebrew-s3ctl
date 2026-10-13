class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.33"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.33/s3ctl-darwin-arm64.tar.gz"
      sha256 "2178521b59580fdfc2d1a4b886445ddd281172fc2887120d9ff89fdaea4d7476"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.33/s3ctl-darwin-amd64.tar.gz"
      sha256 "9bd69bad6611ab178168922798386ed56d7384fb1dd9e6fee0442b411f6bda53"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.33/s3ctl-linux-arm64.tar.gz"
      sha256 "4e067502ab1466bd861ef4847e51ac6fb2907c475c6dbebc4f0ee2cc85d88393"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.33/s3ctl-linux-armv7.tar.gz"
      sha256 "6d1b2cdc783710329dcc9f8f54b3865faa929b77a28b45c191df527e3d35f0d8"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.33/s3ctl-linux-amd64.tar.gz"
      sha256 "69c2cd10ae87b013e550349ed1ab753de8674683518c6a1df2e00708dc79ee6b"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
