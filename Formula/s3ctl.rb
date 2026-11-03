class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.37"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.37/s3ctl-darwin-arm64.tar.gz"
      sha256 "fb199049cf29f57d3bee269a45b15343179c7bd58818191e48e0da45674f74ab"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.37/s3ctl-darwin-amd64.tar.gz"
      sha256 "d4919a45bc4a36320dc6ece853648b433a2ea62b27ad94597626e3c6355effbe"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.37/s3ctl-linux-arm64.tar.gz"
      sha256 "63ef9d65619e0da7a218d17909684341cf789f929eeeb75ee475dfbdbbbfd352"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.37/s3ctl-linux-armv7.tar.gz"
      sha256 "fdf735701425a3b5604789f0583f99b39298750134e9cc13edfe4c9f984ed75d"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.37/s3ctl-linux-amd64.tar.gz"
      sha256 "1ebf6dcc5db42cdec35a56238f9c2294dddfac9d9dfabcbbc65a5e63f263fc4f"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
