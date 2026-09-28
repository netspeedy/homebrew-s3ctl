class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.31"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.31/s3ctl-darwin-arm64.tar.gz"
      sha256 "0d05f4c3f86520e1a697e5d10b016c91ea4e1c1b7f440dfc5d37ba48018b905b"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.31/s3ctl-darwin-amd64.tar.gz"
      sha256 "71c065944a0eed86fc3dd3e3ed6484a2096ad17cbfcaf493edb642da53120be7"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.31/s3ctl-linux-arm64.tar.gz"
      sha256 "4cc2f525c4b1eb6f067e6cb702a7764f9746fc190377babc892f0051a4c3bc96"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.31/s3ctl-linux-armv7.tar.gz"
      sha256 "927ecd5fb56b44ea99a77ec67ae487c77a2df8d7c148fac22eeb28b5a6f00892"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.31/s3ctl-linux-amd64.tar.gz"
      sha256 "cbbf4e0618ad1d5d2d5a04c09aad8e65197def9621ea2627e1c8acdbc78e51b4"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
