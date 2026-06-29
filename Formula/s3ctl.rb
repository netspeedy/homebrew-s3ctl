class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.1/s3ctl-darwin-arm64.tar.gz"
      sha256 "2bc5d0873b2c776c0467de78906e2a0c31088475b9267ae0029749baae758edc"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.1/s3ctl-darwin-amd64.tar.gz"
      sha256 "0f51576c2e867dd99e787933c4c06852d1039f97d83552fb5cdc3f33b7374254"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.1/s3ctl-linux-arm64.tar.gz"
      sha256 "706337881263db68ee6b37ca8d875da3f91989e2e928a10070e305bf61f54823"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.1/s3ctl-linux-armv7.tar.gz"
      sha256 "8078d59b4973ed64eb7aac6dadb5823a446139c1f86f810877d9d74ce9fa1fd7"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.1/s3ctl-linux-amd64.tar.gz"
      sha256 "1bd8f92b7588554929de3ca03b7d595740b4cb45b764a5cece0ea1bf8d5290f1"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
