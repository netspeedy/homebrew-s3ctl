class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.6.2"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.2/s3ctl-darwin-arm64.tar.gz"
      sha256 "240ca1c01f2ae4211098af168208e5e662913cc5e7b919fc91dda606bd159a22"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.2/s3ctl-darwin-amd64.tar.gz"
      sha256 "badaa28fa900587220dedc25f51faf89d36c7bc88a818d2357d44e7fbe50c732"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.2/s3ctl-linux-arm64.tar.gz"
      sha256 "59883b8c9666efb2ad156c1c9c64ea64562a9370d548d8e35a4db2a219cf8a91"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.2/s3ctl-linux-armv7.tar.gz"
      sha256 "6b2e248766598e5bbf5d4cc41b240e4150e3c35e0955fbbc087753f2704a83d7"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.2/s3ctl-linux-amd64.tar.gz"
      sha256 "8f7fa206476a23493f93cade62467800152c55f3c8386676b49e303c4191260d"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
