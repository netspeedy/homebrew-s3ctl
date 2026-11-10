class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.42"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.42/s3ctl-darwin-arm64.tar.gz"
      sha256 "88de5cd023e28baad8b6c23592020c01ca03f3e87cf95ea21173ababf156fd70"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.42/s3ctl-darwin-amd64.tar.gz"
      sha256 "69dd8c16b54ca0b434cde7d2be24b04f7d703ea331c1c2462edb7f8e29db0982"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.42/s3ctl-linux-arm64.tar.gz"
      sha256 "df5377e75b86818794576f1b6d4112220fc04192231540f5c875a1a034903805"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.42/s3ctl-linux-armv7.tar.gz"
      sha256 "f3732555198bfee0b4ec0ba234f6682ed2904302c6fa66d951cc3449690c9efa"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.42/s3ctl-linux-amd64.tar.gz"
      sha256 "4d6c5fbf23206ca36031535a4ba019f7a78b56847b3dfd479928c5b317b3fece"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
