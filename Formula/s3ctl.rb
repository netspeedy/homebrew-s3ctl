class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.19"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.19/s3ctl-darwin-arm64.tar.gz"
      sha256 "28c61eabf73236716df59a3bdd78254a9c299a6a572447d0aaf5cfefa94b2ee5"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.19/s3ctl-darwin-amd64.tar.gz"
      sha256 "a3e96b91fa635dea77da91c9ce978e9001934a503cb28de2dff8649ec44977c1"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.19/s3ctl-linux-arm64.tar.gz"
      sha256 "bc4a381467c06059e237947bc743ed2d6abf2b4e1897ed143cbfcd8b1107405b"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.19/s3ctl-linux-armv7.tar.gz"
      sha256 "be7590ece00dc9be5a73f21ca895961e830b57a44455c60314771b22eb443653"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.19/s3ctl-linux-amd64.tar.gz"
      sha256 "13d71b801f237061afb011971fe6f4797789164df9be9a5c6ba0fc23e6a48d1e"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
