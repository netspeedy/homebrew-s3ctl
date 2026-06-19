class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.6.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.0/s3ctl-darwin-arm64.tar.gz"
      sha256 "39ea4eb7968225af424e5d01fac90b73ac1d02656065eef5f6ed60e81afd4e93"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.0/s3ctl-darwin-amd64.tar.gz"
      sha256 "814dce88478788d27c307e56ee955b7440987bd0308048d04dc98f6f05e01004"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.0/s3ctl-linux-arm64.tar.gz"
      sha256 "c3353eb1de8991bb26d1e323aa7b6304ef38d6c22b6f06e97e8137b28b1f48df"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.0/s3ctl-linux-armv7.tar.gz"
      sha256 "47a577d6786b0496c1eb9b7b063cd5b5ffe4eb024e7452b30e30aa4cca577a67"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.0/s3ctl-linux-amd64.tar.gz"
      sha256 "5337d5e36347c33a3d1fc4c7c2ee78cb12f7c2469ca1b6b855045c235ef4737e"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
