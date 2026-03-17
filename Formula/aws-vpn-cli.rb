class AwsVpnCli < Formula
  desc "CLI for AWS Client VPN with SAML authentication"
  homepage "https://github.com/jlars22/aws-vpn-cli"
  url "https://github.com/jlars22/aws-vpn-cli/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "a6621a2291239ea76ff90b19647b65b86b036f72b5e5dd85bb31c1257fdd81c5"
  license "MIT"

  depends_on "go" => :build
  depends_on :macos

  def install
    system "go", "build", "-o", "saml-server", "server.go"

    libexec.install "vpn"
    libexec.install "saml-server"
    libexec.install "route-up.sh"
    libexec.install "dns-down.sh"

    chmod 0755, libexec/"vpn"
    chmod 0755, libexec/"route-up.sh"
    chmod 0755, libexec/"dns-down.sh"

    bin.install_symlink libexec/"vpn"
    zsh_completion.install "_vpn"
  end

  def caveats
    <<~EOS
      Import your profiles from the AWS VPN Client:

        vpn import
    EOS
  end

  test do
    assert_match "aws-vpn-cli", shell_output("#{bin}/vpn --version")
  end
end
