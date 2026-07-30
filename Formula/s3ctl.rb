class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.11"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.11/s3ctl-darwin-arm64.tar.gz"
      sha256 "c7725c90b7649cef3aea5d282a6cbb38293f1a726e40ef58db77440a0b94fb4a"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.11/s3ctl-darwin-amd64.tar.gz"
      sha256 "c2705526e34ade33984bc323ec625a320850e305281eeb78f9ca5f752356050d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.11/s3ctl-linux-arm64.tar.gz"
      sha256 "1ae42accfad0bfd979fe33b24e1de9fd3241bdfccce3c170c3a8cdd46a7da89a"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.11/s3ctl-linux-armv7.tar.gz"
      sha256 "6f50feabf1044be2af21aa102d4c82e7e02f5774a42bb57def444c99f46582bc"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.11/s3ctl-linux-amd64.tar.gz"
      sha256 "517ff5fb050e897780a7a2e77ae08c40c1a491e6bfd6f3e9b757b8393576514d"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
