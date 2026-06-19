class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.7.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.7.0/s3ctl-darwin-arm64.tar.gz"
      sha256 "60fd966c638be6097820367cefd34368210fa3fab6cd6de7a0a9c9e9226676df"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.7.0/s3ctl-darwin-amd64.tar.gz"
      sha256 "f4fd29b6a61a5a307cd3ef89f7af714111df52579b26d0c302058a0fbb0c0550"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.7.0/s3ctl-linux-arm64.tar.gz"
      sha256 "0ef2b06ba52898ee88d209a1d0a2ed440a626e35ef5252f41da0da51a5d3a36a"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.7.0/s3ctl-linux-armv7.tar.gz"
      sha256 "8f07609a507038b07978f88be8e33b6d44347afb376801db76353d1ba7ba893b"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.7.0/s3ctl-linux-amd64.tar.gz"
      sha256 "e4bf4080c4f99f19d75c88deb843a89816a535edc0233df1da0a31f903a8ac38"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
