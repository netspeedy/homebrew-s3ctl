class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.48"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.48/s3ctl-darwin-arm64.tar.gz"
      sha256 "c360e55a347cc2e818d0cfc8cfcd93cacdf33dad90ae4f6ffa45955db6fce316"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.48/s3ctl-darwin-amd64.tar.gz"
      sha256 "c65020dc1cd8ff5a9d5b26cabb007ac0412ec7a4edcf76fd5fdab516247e3315"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.48/s3ctl-linux-arm64.tar.gz"
      sha256 "38acc60c5f7e8688f9c5c09413f6ced276b0c7a4a71442a617b64c687b355b17"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.48/s3ctl-linux-armv7.tar.gz"
      sha256 "d7ed7d7a1e8fa9db65fa4679f0292ca323ebc7db001625155ad9acab89cdb22c"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.48/s3ctl-linux-amd64.tar.gz"
      sha256 "6badc3704610f2bf5741c88dd4f51b92f752703c806bc50c59052c7946f4c459"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
