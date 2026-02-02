# Homebrew formula for ihistory
# Place this file at Formula/ihistory.rb in repo: homebrew-tap
# Install: brew install jazzjackrabbit/tap/ihistory

class Ihistory < Formula
  desc 'A minimal, fast, fuzzy shell history search tool'
  homepage 'https://github.com/jazzjackrabbit/ihistory'
  version '0.1.2'
  license 'MIT'

  on_macos do
    on_arm do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-aarch64-apple-darwin.tar.gz"
      sha256 '2b8236aee41741b1e4ac26618a1773d618ea40767ad451004d3a8da9db508e43'
    end

    on_intel do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-x86_64-apple-darwin.tar.gz"
      sha256 'e2dba559f885c46f7c1945132ceb23d83b955664cab25cd983422bcb5f100b13'
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-aarch64-unknown-linux-gnu.tar.gz"
      sha256 '767873880755c7da5ffc3c8027f4a6089566f89425b4692c1910cfc8d44befac'
    end

    on_intel do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-x86_64-unknown-linux-gnu.tar.gz"
      sha256 'e179b79d98d19c520acb2e6dbdcef819ee3db85f503c0917975419cb336ec1ad'
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
