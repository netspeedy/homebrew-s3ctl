class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.27"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.27/s3ctl-darwin-arm64.tar.gz"
      sha256 "d2798d5a67d01df4f5d7b2913b484b8a180e50314a75e92409efb40b9d85532c"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.27/s3ctl-darwin-amd64.tar.gz"
      sha256 "b5b3448c77042b7ccdce6159684df03d4713507d7585224cba7fc59ae4ff374c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.27/s3ctl-linux-arm64.tar.gz"
      sha256 "e05239fc7b41b856f3d5786405523b18dd958eccedb630dd792559e308b8cdf2"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.27/s3ctl-linux-armv7.tar.gz"
      sha256 "481181626da5988b3b2b2e0ddd1958b01e7611774971fd3e192109641c95047a"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.27/s3ctl-linux-amd64.tar.gz"
      sha256 "3870a8dbfd7f9c3571ccf2ecb84e7e4ff7b0ae8f57237ae434426ef1182e4a64"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
