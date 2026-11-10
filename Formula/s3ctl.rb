class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.41"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.41/s3ctl-darwin-arm64.tar.gz"
      sha256 "c514fff3e02d7c09f3892b12924bf4b60db5f29644413e18bff01354d2ded9a3"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.41/s3ctl-darwin-amd64.tar.gz"
      sha256 "526d37a91f91e7aa08454a9db5fc1b72a22d9b4f00c0df22c5300d87bdc42776"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.41/s3ctl-linux-arm64.tar.gz"
      sha256 "1bc77592b4bb30ddfac29a097cbcf71b8a762b435583fc2f87e9bd1b282dd662"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.41/s3ctl-linux-armv7.tar.gz"
      sha256 "46bb812722aa4670da5cae8b86569702a34138ca07cbbaa12d320261ca9a00e8"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.41/s3ctl-linux-amd64.tar.gz"
      sha256 "0e514691e653d4a907d7dd042f1b4b845742b4db859433e484453158e47a89f0"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
