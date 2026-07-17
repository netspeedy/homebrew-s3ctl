class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.7"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.7/s3ctl-darwin-arm64.tar.gz"
      sha256 "1d1e9d75ddb8cbbceda0305e33769d7fa91247c5f820c80f376956f6fa8e1ad6"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.7/s3ctl-darwin-amd64.tar.gz"
      sha256 "6d836727b5a1f84f26906797f44a3712181fdd51e52de12faaf184f10f04d692"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.7/s3ctl-linux-arm64.tar.gz"
      sha256 "2b6757315f28e647e3beb45222ee2b9f6d61bdf3c8c413806ad93ba5421373d0"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.7/s3ctl-linux-armv7.tar.gz"
      sha256 "7cf0e3a38c7fa4b3592a606dd547edc7a881746b05a9f5b41e38a8b6ae9e571f"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.7/s3ctl-linux-amd64.tar.gz"
      sha256 "fd0779ca3f94a0baee1c493f651dfdd6300f881bd3ce070ec0b257000656ba5f"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
