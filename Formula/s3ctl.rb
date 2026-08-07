class S3ctl < Formula
  desc "S3-compatible bucket provisioning and scoped credential automation"
  homepage "https://github.com/netspeedy/s3ctl"
  version "0.8.14"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.14/s3ctl-darwin-arm64.tar.gz"
      sha256 "c07214fe4eecf8dbb658c95035bae1a54cd7980a21f4f71d90f0409d8192d8c0"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.14/s3ctl-darwin-amd64.tar.gz"
      sha256 "81697483ccb48d4a34c6dd737f20fd9940adfd3c0c37d27cea94b207128b0722"
    end
  elsif OS.linux?
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.14/s3ctl-linux-arm64.tar.gz"
      sha256 "20f69017fd0a53eeda3497e5312fc40acb47792391f4e0685a5effd444f899fa"
    elsif Hardware::CPU.arm?
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.14/s3ctl-linux-armv7.tar.gz"
      sha256 "a96cb59b92715d9f4e14b9efd22db1b8aa4b960bdcc57418559596502990e92d"
    else
      url "https://github.com/netspeedy/s3ctl/releases/download/v0.8.14/s3ctl-linux-amd64.tar.gz"
      sha256 "c46018edf408d89b64cebf4728eb774eded31cdd002ddadacae27be52d0a4d33"
    end
  end

  def install
    bin.install Dir["s3ctl-*"][0] => "s3ctl"
  end

  test do
    assert_match "Version:", shell_output("#{bin}/s3ctl --version")
  end
end
