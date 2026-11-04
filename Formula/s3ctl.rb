class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.38"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.38/s3ctl-darwin-arm64.tar.gz"
      sha256 "3541df21ac6824e246615f01163eac8131e44d292f39260eddb9c92b02bb4a2c"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.38/s3ctl-darwin-amd64.tar.gz"
      sha256 "1cdfb71d585aafcac015c2f9f60f9dfb1d8720fad51cf7f9a60028d065a1d467"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.38/s3ctl-linux-arm64.tar.gz"
      sha256 "f76a7f31b634fd2e19843c1c65b69a36b7d971b6a875b1609577a351f588fb01"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.38/s3ctl-linux-armv7.tar.gz"
      sha256 "c1d0f7a2f9c48fa1ada26dec611a6610edd7d2b1a81b1099e3592a2b3eda0aee"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.38/s3ctl-linux-amd64.tar.gz"
      sha256 "36a2f357d60de3493b5686b9285424c826fdea288709c49d414f10de3ae451eb"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
