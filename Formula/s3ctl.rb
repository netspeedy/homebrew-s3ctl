class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.25"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.25/s3ctl-darwin-arm64.tar.gz"
      sha256 "d160c26b733b11cfc841530fa2bae157d2f1aef5e55061652803c1a24ea4e91e"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.25/s3ctl-darwin-amd64.tar.gz"
      sha256 "0be29dfc9ef100334ac78c7ea13a201ecd64b36db38c8b4837ff442ac7f40708"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.25/s3ctl-linux-arm64.tar.gz"
      sha256 "9c1880ad29753c2a061068d6a4920bf9a079eb8212639ba532aec2bb04bf066b"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.25/s3ctl-linux-armv7.tar.gz"
      sha256 "92b18a560b15b61fb5d929a747a924a760451df32db190c7a3510ad8f02edb4f"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.25/s3ctl-linux-amd64.tar.gz"
      sha256 "205e920f9fd7e7a8685cd81241c7aabca903548ca026f45e861c95197a4dccdd"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
