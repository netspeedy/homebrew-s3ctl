class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.12"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.12/s3ctl-darwin-arm64.tar.gz"
      sha256 "d86a0a99c9426ccec096f2afc1cc90f72a59225425d8e7a92edf2618189d189e"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.12/s3ctl-darwin-amd64.tar.gz"
      sha256 "66fd5086da88683d7249ead55370bd980f6516b0ccd0196fc5e23de63c08d6ce"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.12/s3ctl-linux-arm64.tar.gz"
      sha256 "be5f0dfe1c4eff35ef2da1cc0c7ea8f9703e6051584028ab698efb4c85c18188"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.12/s3ctl-linux-armv7.tar.gz"
      sha256 "02f68251ea88d2ae34514770ad4e016b9e26427b64dbed2b5a41c06d013c8e69"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.12/s3ctl-linux-amd64.tar.gz"
      sha256 "b3794c3ebbdac5ce18c802b1ed96a0503d15d36a2d438dd8576d0a75618d6b82"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
