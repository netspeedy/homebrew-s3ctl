class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.15"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.15/s3ctl-darwin-arm64.tar.gz"
      sha256 "143d65e35449c7281acb82328ce8433f62749645ca09a8d42ed12e1fc0108790"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.15/s3ctl-darwin-amd64.tar.gz"
      sha256 "d4c6102bff79d0c7fc67e085e448e459754abd508b773630850b59866bb71302"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.15/s3ctl-linux-arm64.tar.gz"
      sha256 "d55ebb5c565f2604fffd8527ad524d7f4bec7db7ab44c5bed9a8a854d8b7aecb"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.15/s3ctl-linux-armv7.tar.gz"
      sha256 "64b3eda4d2ae2f82689032f701ee32e75825c28449d26ba1d5154c2c851282fb"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.15/s3ctl-linux-amd64.tar.gz"
      sha256 "9a51d4fb8dee6e4421b0a4111bcf159e6138e95061dcffb4a7f3aba05124c7c7"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
