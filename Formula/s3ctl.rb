class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.8"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.8/s3ctl-darwin-arm64.tar.gz"
      sha256 "fb4fc8e21e20d68363df51505871d9782e245bf9b0b98d442fc332a315a46fc4"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.8/s3ctl-darwin-amd64.tar.gz"
      sha256 "88ef0852df070e96612c1b087d139c93a6df97ba0943bf3ec4798375c0b1eb7f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.8/s3ctl-linux-arm64.tar.gz"
      sha256 "02b96c96c2a28bcff792b7b600cb0826d268d915a96c248b154b9a3df9a6a311"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.8/s3ctl-linux-armv7.tar.gz"
      sha256 "41f3bfe048e14ed2344ac5ccf469e1a00c645737671edf1c35bd5d02b1b2fd1d"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.8/s3ctl-linux-amd64.tar.gz"
      sha256 "199c399ff1a7cf777fb1a833e9979b07872031501157287d458a72bc4e3df566"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
