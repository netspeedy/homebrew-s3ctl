class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.35"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.35/s3ctl-darwin-arm64.tar.gz"
      sha256 "4a621ce98fe802e08ae087c1cb11ae500aebce6c063260abe4341ee69beaf648"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.35/s3ctl-darwin-amd64.tar.gz"
      sha256 "9e799ef094073b987afcb1fb67506222c9e7019323380d951060b65e309b018c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.35/s3ctl-linux-arm64.tar.gz"
      sha256 "383cd2094539fc3435f9d06b43d526edad9a18950fcd8bd7d2f9f5b520e8e8d5"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.35/s3ctl-linux-armv7.tar.gz"
      sha256 "5e03099a9e75540169c3c577f0e5bf5ea980261f30be79e3c86df5d3cef9f4db"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.35/s3ctl-linux-amd64.tar.gz"
      sha256 "562c49032c81542c1fe08b9edc5c31efca4bcba586cc27d905572f41bb16e35d"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
