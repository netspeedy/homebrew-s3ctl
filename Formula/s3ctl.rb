class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.22"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.22/s3ctl-darwin-arm64.tar.gz"
      sha256 "4a97cfd0596decc308ce5e90eeb6c592ced6d86916d9b6d3005fc350b673d59e"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.22/s3ctl-darwin-amd64.tar.gz"
      sha256 "9c7c5651d19e71695040bc3910b712045771c55e311c92a1a0e5166ac585b62c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.22/s3ctl-linux-arm64.tar.gz"
      sha256 "be3134a61df139101584a9c680f34d8551b66c45e814326b243f903c71c019e4"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.22/s3ctl-linux-armv7.tar.gz"
      sha256 "04b6f17e602c664d689f4c64612976c16483f0f3d3fbf02926983fb63e7004b1"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.22/s3ctl-linux-amd64.tar.gz"
      sha256 "f071ed095e1e764ecd6d413452ea6d21096b29876b6ad5871a7e2bc3204ee976"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
