class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.44"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.44/s3ctl-darwin-arm64.tar.gz"
      sha256 "d3b5b52860b7157cc86388beacc52081239f8d2794f4e17b1e780af284666d9b"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.44/s3ctl-darwin-amd64.tar.gz"
      sha256 "7a9beab1583525cf63fc59439a6e86fe05f2bb60a02c358e0778863df4d1462f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.44/s3ctl-linux-arm64.tar.gz"
      sha256 "4b6d8a23bc9a6b4865ffdc2019a051287f5d3f043c5dee432432d1d30fafbcfe"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.44/s3ctl-linux-armv7.tar.gz"
      sha256 "6f35d4b42964dd6713f905d57a4973bb11985a531b57b2999ed2856ee5a635ab"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.44/s3ctl-linux-amd64.tar.gz"
      sha256 "ca3dbf3959319d6ba774d88c285fadb26533abc782383e918d3b7fe842b2972c"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
