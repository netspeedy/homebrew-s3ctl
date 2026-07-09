class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.5"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.5/s3ctl-darwin-arm64.tar.gz"
      sha256 "3f3ad8d860e78ee275041b2f927c4aa360f738092a30a20554476c6bc0d05381"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.5/s3ctl-darwin-amd64.tar.gz"
      sha256 "e3dea4e6a277cab9a58bdc6f83d55ac0aaab730622d468fcdcf8a72b65097de7"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.5/s3ctl-linux-arm64.tar.gz"
      sha256 "c6a44eb2b6f1da02f8d36c52bbdc1da2bff01a8ef55d49682fabf0e4af640a9c"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.5/s3ctl-linux-armv7.tar.gz"
      sha256 "262ee3628a25312aebe861555431737852da6b58a9687150c8eb1a3ec40542d9"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.5/s3ctl-linux-amd64.tar.gz"
      sha256 "432b1cac26792d1705ee7ada9c1a1d91edbacaa433cd67a4c9e204cd5e3978b0"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
