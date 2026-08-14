class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.17"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.17/s3ctl-darwin-arm64.tar.gz"
      sha256 "b34804593bf9538f2a8d56b445c7fc191049f4110460ef5bc77e2d165393a20e"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.17/s3ctl-darwin-amd64.tar.gz"
      sha256 "a7618bccf2de2788f0cd6c700c067438667a2fda6ea81fa6d57bb52b17edf73d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.17/s3ctl-linux-arm64.tar.gz"
      sha256 "8e57ac843f730c07902a5c3a8de660e19c4019a484019aafb23838579d665103"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.17/s3ctl-linux-armv7.tar.gz"
      sha256 "ef4c8cbedc70d6ac99f9bad74379268ad968a110c358c450fc1bfa3b14177837"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.17/s3ctl-linux-amd64.tar.gz"
      sha256 "890ccd5200302f20d43517c3d62b5a19b5a32e952ea2ef19b4ad6f596222df70"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
