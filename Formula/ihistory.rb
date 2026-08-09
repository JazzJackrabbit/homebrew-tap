# Homebrew formula for ihistory
# Place this file at Formula/ihistory.rb in repo: homebrew-tap
# Install: brew install jazzjackrabbit/tap/ihistory

class Ihistory < Formula
  desc 'A minimal, fast, fuzzy shell history search tool'
  homepage 'https://github.com/jazzjackrabbit/ihistory'
  version '0.1.4'
  license 'MIT'

  on_macos do
    on_arm do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-aarch64-apple-darwin.tar.gz"
      sha256 '180edd2c366d059c50e6e42ca48e3713e8b8930e8b5be100de87db56b5ebec01'
    end

    on_intel do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-x86_64-apple-darwin.tar.gz"
      sha256 'f068efcef89853aa9945f2f1be6b6ac08bfac00d02b2eb5a708afd3bca687818'
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-aarch64-unknown-linux-gnu.tar.gz"
      sha256 '4038e305cbe858e43883430bc52eec881fb3e709341f520f47d0e02ca5b8cbdb'
    end

    on_intel do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-x86_64-unknown-linux-gnu.tar.gz"
      sha256 '6a6b091f675128428a9130f0b4bbb50ab326c60ad43d50fd3b01438d7cd5a088'
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
