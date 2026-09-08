class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.24"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.24/s3ctl-darwin-arm64.tar.gz"
      sha256 "16f69696debfc76832d8e1b580f1a1cf12c7f0a08f4ccc1f5ee1a65ba939dcc4"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.24/s3ctl-darwin-amd64.tar.gz"
      sha256 "949e9fc0e0e4a7e1ec65327d66be9ddb87b4b679a4a5535b7eb766288ed902c4"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.24/s3ctl-linux-arm64.tar.gz"
      sha256 "941798f65c6231cd2ce9319a485973353703ab4d8b2ea4e122a05c67705de5f9"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.24/s3ctl-linux-armv7.tar.gz"
      sha256 "8a5d4601424261353b0b9e621e42560486ca1aa7cfa2db91d0d5af25b4af6e7e"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.24/s3ctl-linux-amd64.tar.gz"
      sha256 "aa087ff16cd27af785c53cfc9f984b397fe333111d50fd8bfb1bd86816dc9832"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
