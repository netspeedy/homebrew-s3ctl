class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.47"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.47/s3ctl-darwin-arm64.tar.gz"
      sha256 "9907be80a650071cb6298451c2776b702fcf560510fa1de6d908d5e101bbd721"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.47/s3ctl-darwin-amd64.tar.gz"
      sha256 "9e3342dedec1e92575014762743b506171c909af7f268869f895f08367cf0fac"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.47/s3ctl-linux-arm64.tar.gz"
      sha256 "52c07e4dc36edba1a9eca20530cab03e25a23213bd6df1e239a3ec84a7a2ad0a"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.47/s3ctl-linux-armv7.tar.gz"
      sha256 "75b11f894d4e104e2bc71b1faa1a6c7fc67aa16d34a3abf765e62b128868fdf6"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.47/s3ctl-linux-amd64.tar.gz"
      sha256 "05b1e11e42719e4c25c51af709f1111033141a1d00d509248a252d8ff7bf0c23"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
