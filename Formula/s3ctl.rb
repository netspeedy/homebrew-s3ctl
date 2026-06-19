class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.0/s3ctl-darwin-arm64.tar.gz"
      sha256 "fef86023d231016462e116908fea2e55262d7f3a28027538b6444ea7bbe5a340"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.0/s3ctl-darwin-amd64.tar.gz"
      sha256 "baa8d61467c4961da19b8ad4d52bf8ffe68e6d1d07589da3bdf55eb95b5c8bc4"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.0/s3ctl-linux-arm64.tar.gz"
      sha256 "223b3e627d8cbf95cda84c846bcb11f7c49d8d4a112759a3903462eb1a26ebfe"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.0/s3ctl-linux-armv7.tar.gz"
      sha256 "5bd71f3e52ed0ac53cb7313479265f0350e5bceabba9d794ca29e7024d7ab5c5"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.0/s3ctl-linux-amd64.tar.gz"
      sha256 "4662bdd7efbd0b7069008ee1508bea764c777b321604f7b802241c0c1720bed7"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
