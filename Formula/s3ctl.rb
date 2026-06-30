class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.2"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.2/s3ctl-darwin-arm64.tar.gz"
      sha256 "9c1eb059b49ce419f8fbf4f6f22116a59ff05567da0aa26d15b2bd0cef583fc9"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.2/s3ctl-darwin-amd64.tar.gz"
      sha256 "ff5e4dccd9a0b129e32753081e7cb0738d99fc3068f36c0d121a16eda9499ea9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.2/s3ctl-linux-arm64.tar.gz"
      sha256 "ea7e9589d506f11ea469a1921b4063c26238edab845080744c9e2deca6efd4cc"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.2/s3ctl-linux-armv7.tar.gz"
      sha256 "6b022ab5a144cafff83466e9ab8dfd5018c5b380a59bf47f882d89baee9e3c63"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.2/s3ctl-linux-amd64.tar.gz"
      sha256 "71d7c233aea4c7fcd8e0f6e0fba99dcb12d6439ab7c968062d25890c4bfaf1ea"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
