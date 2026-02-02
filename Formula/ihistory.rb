# Homebrew formula for ihistory
# Place this file at Formula/ihistory.rb in repo: homebrew-tap
# Install: brew install jazzjackrabbit/tap/ihistory

class Ihistory < Formula
  desc 'A minimal, fast, fuzzy shell history search tool'
  homepage 'https://github.com/jazzjackrabbit/ihistory'
  version '0.1.1'
  license 'MIT'

  on_macos do
    on_arm do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-aarch64-apple-darwin.tar.gz"
      sha256 'af71ee7460d7532a44338c20f93901fcf9dcc4987725258863819608d329a99b'
    end

    on_intel do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-x86_64-apple-darwin.tar.gz"
      sha256 'e2279b77995bf65add4434f088bbaaf55fbc89293284de303678043bfb808f6b'
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-aarch64-unknown-linux-gnu.tar.gz"
      sha256 'a9aaa35eaa97cfd94d46485ffab5f533b9a72a4ddf20759ee2ce8b9d7b59ab2b'
    end

    on_intel do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-x86_64-unknown-linux-gnu.tar.gz"
      sha256 'c7f3d62edcdf16c03be2a6f707562edce41193ec2c9e38476da4482f2b7b8203'
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
