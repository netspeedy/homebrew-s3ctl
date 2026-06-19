class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.5.23"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.5.23/s3ctl-darwin-arm64.tar.gz"
      sha256 "60c4981671214ed9b96652aad89db89e5493af84ab606f105be0b21dcd768aaa"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.5.23/s3ctl-darwin-amd64.tar.gz"
      sha256 "a5a2f17bbbedc941433c8467d21ac94a48fbd72aaaa7c98a834e53fa68c6fb9d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.5.23/s3ctl-linux-arm64.tar.gz"
      sha256 "e78425dff23b50ba84efa871ee6cb85d3b9739ce39088105ed01666ca74c5965"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.5.23/s3ctl-linux-armv7.tar.gz"
      sha256 "3568f235ab54ade11e1d54d621e74badc9e03dcf16075083026015df0b0d36de"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.5.23/s3ctl-linux-amd64.tar.gz"
      sha256 "ea9d684909a7a966a763f124692487202ad4f8ac4bc3ce681af0bfe79fa4b778"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
