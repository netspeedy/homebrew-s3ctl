class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.32"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.32/s3ctl-darwin-arm64.tar.gz"
      sha256 "42c89c5a7a6d6743bd42fb529480b2de9b5b03ac51081807a3b0ab57efc8f148"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.32/s3ctl-darwin-amd64.tar.gz"
      sha256 "daccf5cece7edc7da03bbaadade1d15841be8b34aa6aec538583c3e84c630e04"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.32/s3ctl-linux-arm64.tar.gz"
      sha256 "8c1d07550ccb712893fdee85c0753ff06743d7865d65cde342e60049826b1993"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.32/s3ctl-linux-armv7.tar.gz"
      sha256 "f9844b491c89af849b878ec642028478eccf1671495d664889a602d60c4cc4e0"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.32/s3ctl-linux-amd64.tar.gz"
      sha256 "d22ab3f00db7f578ef919ac45371110f80d30edd8df594e202b6ba4a711134af"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
