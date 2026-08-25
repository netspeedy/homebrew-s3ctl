class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.20"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.20/s3ctl-darwin-arm64.tar.gz"
      sha256 "b074bf18dbb0f40800f65e7d1eef57921fcf7b3f950b5f6438b6cd901cc1d47b"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.20/s3ctl-darwin-amd64.tar.gz"
      sha256 "49d80289b0e025f423387cc52c6421eb368715e88ba239bb312c322c1232e7e9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.20/s3ctl-linux-arm64.tar.gz"
      sha256 "33cd26bae8bcc98d4719328e6b50190fc90754369f6da731343403a11e67ee5a"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.20/s3ctl-linux-armv7.tar.gz"
      sha256 "ca6b92a449314280ff3619aa2547ad2d2bc5b83cb26e282290944e843f40bcef"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.20/s3ctl-linux-amd64.tar.gz"
      sha256 "414ab94e5f87ecd121fe94d068172ef60927c3bb84d15cbbf034f9375080cbaf"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
