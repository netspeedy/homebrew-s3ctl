class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.6.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.1/s3ctl-darwin-arm64.tar.gz"
      sha256 "c2fb2d8e61ce36b6bfa5e59794e2dd62ccbfaa9940c9d6d309bf962c866659f4"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.1/s3ctl-darwin-amd64.tar.gz"
      sha256 "1d82ba4c2d912062a2a647c3870d7608f7eb0b10e285b36c933d9e1088b6b2ae"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.1/s3ctl-linux-arm64.tar.gz"
      sha256 "6f9b42b646590d58bf37eead992a7d0c5e09680652e26ef3601100e09fe2ee23"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.1/s3ctl-linux-armv7.tar.gz"
      sha256 "922e18681e1014342d384a70c1aef93e4cefef49d0ad5993765bb1c5682cfd17"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.1/s3ctl-linux-amd64.tar.gz"
      sha256 "292601cd55969ee75fa66d8e6c0272854cf415edbddbc0104123a3ef4147f06e"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
