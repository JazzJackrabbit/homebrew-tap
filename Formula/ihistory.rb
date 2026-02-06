# Homebrew formula for ihistory
# Place this file at Formula/ihistory.rb in repo: homebrew-tap
# Install: brew install jazzjackrabbit/tap/ihistory

class Ihistory < Formula
  desc 'A minimal, fast, fuzzy shell history search tool'
  homepage 'https://github.com/jazzjackrabbit/ihistory'
  version '0.1.3'
  license 'MIT'

  on_macos do
    on_arm do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-aarch64-apple-darwin.tar.gz"
      sha256 'f6f9542faaf9eced05bbef6267e778206a3bade53f89e2bf3889011cd7c0c7ef'
    end

    on_intel do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-x86_64-apple-darwin.tar.gz"
      sha256 'a8fe2035dfffa71a96dc4a4a4eb4ea16230405afddf449fa9f2264b47ee17aef'
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-aarch64-unknown-linux-gnu.tar.gz"
      sha256 '8ef64f24c5a6a25708e915c18249d99f426c3e1313d322416bc053703f500674'
    end

    on_intel do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-x86_64-unknown-linux-gnu.tar.gz"
      sha256 '185afd64cbe32639bd04d0f9d094e9b45b380911e5d1b4213839f3850e36469c'
    end
  end

  def install
    bin.install 'ihistory'
    bin.install_symlink 'ihistory' => 'ih'
    (share / 'ihistory').install 'shell/ihistory.sh'
  end

  def caveats
    <<~EOS
      Add to your ~/.zshrc or ~/.bashrc:
        source "#{opt_share}/ihistory/ihistory.sh"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ihistory --version")
  end
end
