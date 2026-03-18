class AwsVpnCli < Formula
  desc "CLI for AWS Client VPN with SAML authentication"
  homepage "https://github.com/jlars22/aws-vpn-cli"
  url "https://github.com/jlars22/aws-vpn-cli/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "b35bc4fffdb6a34b8b0225d67f0b285a2554871f7395f5815af274e84de9400b"
  license "MIT"

  depends_on "fzf"
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
      Get started:

        vpn
    EOS
  end

  test do
    assert_match "aws-vpn-cli", shell_output("#{bin}/vpn --version")
  end
end
