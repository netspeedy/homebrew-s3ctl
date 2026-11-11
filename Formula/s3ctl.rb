class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.43"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.43/s3ctl-darwin-arm64.tar.gz"
      sha256 "4ef1a7d463d9318444f0ea795d943a4d9ad2c4f8d595f7a79b7049d359894a3c"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.43/s3ctl-darwin-amd64.tar.gz"
      sha256 "94fa817993688800e1173e8e81a544c2cdbbd0054e2f6b6461bd6528e75238d2"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.43/s3ctl-linux-arm64.tar.gz"
      sha256 "8de3148d2e325995791ab7566455ec6f98705ccd94dfaf0cf8006b3c8cf301c5"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.43/s3ctl-linux-armv7.tar.gz"
      sha256 "1c55f3c79f11b62ec95029598d373bf00fff3ef671fee16cbe7079cae2720f05"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.43/s3ctl-linux-amd64.tar.gz"
      sha256 "aaa7122c94d6199a06b1b21f6f440f75366c43e6aa9804ad5e0a4cdb76923055"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
