class AwsVpnCli < Formula
  desc "CLI for AWS Client VPN with SAML authentication"
  homepage "https://github.com/jlars22/aws-vpn-cli"
  url "https://github.com/jlars22/aws-vpn-cli/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "3ca98ef54e85ff7f673a248bfc14b57aae3c0ba1a3975479fc638cd8e5dad30b"
  license "MIT"

  depends_on "fzf"
  depends_on "python@3"

  def install
    libexec.install "vpn"
    libexec.install "saml-server.py"
    libexec.install "route-up.sh"
    libexec.install "dns-down.sh"

    chmod 0755, libexec/"vpn"
    chmod 0755, libexec/"route-up.sh"
    chmod 0755, libexec/"dns-down.sh"

    bin.install_symlink libexec/"vpn"
    bash_completion.install "vpn.bash" => "vpn"
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
