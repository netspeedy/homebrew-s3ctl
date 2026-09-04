class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.23"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.23/s3ctl-darwin-arm64.tar.gz"
      sha256 "223a25326de010c523380734c6462d32bb66779a43242560d9bec0ef0b16b90d"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.23/s3ctl-darwin-amd64.tar.gz"
      sha256 "f382ee5625d98f73d4fd0004acaf4794c5550b815b81795aa41f6a1382cb0ec7"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.23/s3ctl-linux-arm64.tar.gz"
      sha256 "73e125a17cc7cee99a8892cdb140d0252e74be1ffd70ab11946396aed7b75308"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.23/s3ctl-linux-armv7.tar.gz"
      sha256 "36b328ad6ea85aaeb00af06e062688e4cd67580592139570be84d2ed3cddb8e9"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.23/s3ctl-linux-amd64.tar.gz"
      sha256 "efd8cb2f4a478d2b744fb50f6005a20995196baff4fee6c52ce43104a0efb692"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
