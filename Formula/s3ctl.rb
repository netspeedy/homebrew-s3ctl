class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.40"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.40/s3ctl-darwin-arm64.tar.gz"
      sha256 "4e72d6bf8f59e28820afd30080c4016d9e2419f669aabae22bab9d4d0fce4303"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.40/s3ctl-darwin-amd64.tar.gz"
      sha256 "ea4d9c09f589a49860ef8e7dfa2f1b7b50b442b8673bf79b46cecdb4f967c8b2"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.40/s3ctl-linux-arm64.tar.gz"
      sha256 "7377c21f7b67b8554da92fdfe1407a904f06afc4fd3c13f68f805fe1da60f662"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.40/s3ctl-linux-armv7.tar.gz"
      sha256 "418db996c15628f320b632b39f4c885c52928f4ce61b3d6132404ab74fa5d0af"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.40/s3ctl-linux-amd64.tar.gz"
      sha256 "f23699f3a78049999062dbb1458a7ae1bc2016f2fca2ea072b5849617254787a"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
