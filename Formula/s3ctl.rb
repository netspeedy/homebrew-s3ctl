class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.45"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.45/s3ctl-darwin-arm64.tar.gz"
      sha256 "c455a3b487169b318825cdbd907f922ef3ace626ffe44e47c641f3ca2d24788a"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.45/s3ctl-darwin-amd64.tar.gz"
      sha256 "47695b96ffd17af09a6d06786d425a4837681cd1a8d86f5606e116a42bcab6df"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.45/s3ctl-linux-arm64.tar.gz"
      sha256 "f7136954809e2ba46fa44ef2a5642804a7f4f08c7eafbd60a22d5721c6cf0c9c"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.45/s3ctl-linux-armv7.tar.gz"
      sha256 "ccd35d9e0d53e3f2d60ec10f7d4711716acb0832b26bfa2c84e927047aa7c5d0"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.45/s3ctl-linux-amd64.tar.gz"
      sha256 "0cbf02a6f63199281b1f9024e08b65e3ed5bc6efa8abcb98b67b0e8bac0a425b"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
