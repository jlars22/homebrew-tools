class AwsVpnCli < Formula
  desc "CLI for AWS Client VPN with SAML authentication"
  homepage "https://github.com/jlars22/aws-vpn-cli"
  url "https://github.com/jlars22/aws-vpn-cli/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "e22e910f26a77eab38bac1f73c9ee2dbcb7db9da9559f8ee8520f8a0c97e83d7"
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
