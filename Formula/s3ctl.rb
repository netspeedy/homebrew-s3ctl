class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.6.3"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.3/s3ctl-darwin-arm64.tar.gz"
      sha256 "f704074056bbdcb8275ea3357edfd01f5b0635482bf9ddadad4346ad31324141"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.3/s3ctl-darwin-amd64.tar.gz"
      sha256 "476cf8619871997908dfb12dc7de815d8a518836eb0526c8954b21e179fb7bd2"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.3/s3ctl-linux-arm64.tar.gz"
      sha256 "cbea0da8c52b9c7e18f33c9d4fb532c81c60f2fb5cd75baa1feb1f86eda1d438"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.3/s3ctl-linux-armv7.tar.gz"
      sha256 "c7449355d3008de9a3de25337ae74abd58617e2bddcac30afb16da914f3bddf0"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.6.3/s3ctl-linux-amd64.tar.gz"
      sha256 "90cbb9442194cde619c51f7da9da5a0e0bd224c0172f6b0996a3e20e1f872756"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
