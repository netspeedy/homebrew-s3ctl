class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.46"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.46/s3ctl-darwin-arm64.tar.gz"
      sha256 "234d1a7d785d719d14a771e2f8de892f307a25347f015fefff22b0524e7af1fd"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.46/s3ctl-darwin-amd64.tar.gz"
      sha256 "cd8de5ff5560445d7593c098a20cbcd982961ae8120d2f70aa76a0ec9b2b259c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.46/s3ctl-linux-arm64.tar.gz"
      sha256 "c6089527bc8fe7013e442763398ac558cc4ecd344b9e2b1b8e49eea5f0737bb4"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.46/s3ctl-linux-armv7.tar.gz"
      sha256 "a9e801aa7c6c824f7cec7bf8c083e00563a0e50f17527ffc67ad655da117db8a"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.46/s3ctl-linux-amd64.tar.gz"
      sha256 "c8646bbcd2fd87b5a46d90ffc32640c6b27a64f5e8646dd37ffb8660ed3e21e4"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
