class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.36"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.36/s3ctl-darwin-arm64.tar.gz"
      sha256 "34661b6c86ff20117889654906f9bf04a8a9950afa5827ed037e0d518c27ca00"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.36/s3ctl-darwin-amd64.tar.gz"
      sha256 "47e4e5d5bbfcbd36cb2248f0053978eae1935515442ad4cc596689f992eb43db"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.36/s3ctl-linux-arm64.tar.gz"
      sha256 "8f3041fd01bfc3d1900ed6033eb90821ce0987f0b306a5c86f20c1ac373e8dd9"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.36/s3ctl-linux-armv7.tar.gz"
      sha256 "5e2d5c83194d9379d5082afd11e340341699a0654d03d46f1d376fe50a658eb3"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.36/s3ctl-linux-amd64.tar.gz"
      sha256 "fa1f27dc1de0c792ddd0ed011d785f34eb197e39ca7ebe81aa5d702ad9fd3c0f"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
