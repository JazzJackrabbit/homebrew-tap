# Homebrew formula for ihistory
# Place this file at Formula/ihistory.rb in repo: homebrew-tap
# Install: brew install jazzjackrabbit/tap/ihistory

class Ihistory < Formula
  desc 'A minimal, fast, fuzzy shell history search tool'
  homepage 'https://github.com/jazzjackrabbit/ihistory'
  version '0.1.5'
  license 'MIT'

  on_macos do
    on_arm do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-aarch64-apple-darwin.tar.gz"
      sha256 'ee3e49b041a47bbb499b530fab593e581028de56ac37a12e962093af06fe881a'
    end

    on_intel do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-x86_64-apple-darwin.tar.gz"
      sha256 '1e7d9829e32785e3718d109e13e122774d30d175d8012e5cc9aa159938151374'
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-aarch64-unknown-linux-gnu.tar.gz"
      sha256 '8f06383321e1d9d6c56ddf585d9b1881b4387383301e1a95165c439877014733'
    end

    on_intel do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-x86_64-unknown-linux-gnu.tar.gz"
      sha256 '4a2467062825d15b4022584d789441ee18518087b5ff392005e1d6ccd400f629'
    end
  end

  def install
    bin.install 'ihistory'
    bin.install_symlink 'ihistory' => 'ih'
  end

  def caveats
    <<~EOS
      Run to set up shell integration:
        ihistory --init
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ihistory --version")
  end
end
