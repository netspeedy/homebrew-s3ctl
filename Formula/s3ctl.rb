class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.6"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.6/s3ctl-darwin-arm64.tar.gz"
      sha256 "f2a9b4cd037c3afefd0bdbd81bb48b3a5b5a270255c036a3f165289a76793199"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.6/s3ctl-darwin-amd64.tar.gz"
      sha256 "7f14ae45e5cdae5a888cd4018c6fc360bc5a298e701f4a27a0d0e4070257f0ab"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.6/s3ctl-linux-arm64.tar.gz"
      sha256 "f3f04b4479acf2166e7877884681888a153c024c0367b0d838a393f26c506ddf"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.6/s3ctl-linux-armv7.tar.gz"
      sha256 "7c92289f05b52ab6188c2d83b85f82851ee33a776f830db56baf6b75760b6573"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.6/s3ctl-linux-amd64.tar.gz"
      sha256 "29f06c8ac2467f358e5068cabfe43eca6c3d49a391ae8fa79da37d4fdd6c441a"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
