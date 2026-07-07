class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.4"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.4/s3ctl-darwin-arm64.tar.gz"
      sha256 "cf1550b15a3d8a7fabe8929ada0def28b79f64e947df58828fd8dba09cb2eb5a"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.4/s3ctl-darwin-amd64.tar.gz"
      sha256 "1406b7d0e899a76f68fed5ae506825f3f05be74e6bc1a0d48269607fd5ea525d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.4/s3ctl-linux-arm64.tar.gz"
      sha256 "305271ff361c0d36c2578e829d71fd984788a7ad84215dbc2cc3852a6e48615c"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.4/s3ctl-linux-armv7.tar.gz"
      sha256 "52d656d29ba511abe4d727ee37d9f07f996e1de6e5c063468c089306ad05b3e9"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.4/s3ctl-linux-amd64.tar.gz"
      sha256 "97c8eeb491e2ffbd6dd84a2be33ffc461a1f8288458bd48338eb028354e45a66"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
