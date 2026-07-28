class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.9"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.9/s3ctl-darwin-arm64.tar.gz"
      sha256 "f97c543794f018bebebfd40fc1689cb061180a82c09cedee3af4a0977a4fdc54"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.9/s3ctl-darwin-amd64.tar.gz"
      sha256 "beaa9297d12d7eca5bd4655fe576acd6f44dc4c6927fa94de0228ea88b6a7a3a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.9/s3ctl-linux-arm64.tar.gz"
      sha256 "054929df5060ced6d226242f77e84b312fb04b431ac91e3d5a15048abbc4b8fe"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.9/s3ctl-linux-armv7.tar.gz"
      sha256 "f88c97d9cff07551a441e8fb8c9e4fccac3b03d7d7b40cf0a28d6e27acd7059c"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.9/s3ctl-linux-amd64.tar.gz"
      sha256 "199fb2e9b7eac3acf663751229045778838cd9f2226d1d11d806e8b165233c94"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
