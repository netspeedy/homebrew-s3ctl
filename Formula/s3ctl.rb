class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.34"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.34/s3ctl-darwin-arm64.tar.gz"
      sha256 "1ef416513f5f1cca79e644db316ea509663f41ba1377f697222f4da8897e337e"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.34/s3ctl-darwin-amd64.tar.gz"
      sha256 "d29b86b38f8622d6715f86ebc327d3bed30cc524256c4279b215f6095e9e80ed"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.34/s3ctl-linux-arm64.tar.gz"
      sha256 "794fe471a41f8663ae26fd3a9513b6b6f8c336a5f22466d723ff7b7ee815b143"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.34/s3ctl-linux-armv7.tar.gz"
      sha256 "5f852f68892d8c479a64f0dccc3e37e3942ea1eeb96707e4b486f71c9021973c"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.34/s3ctl-linux-amd64.tar.gz"
      sha256 "8bfa189b35eb28ac895bf9329e6466aaaf218fac658630776320a55667f47034"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
