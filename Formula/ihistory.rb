# Homebrew formula for ihistory
# Place this file at Formula/ihistory.rb in repo: homebrew-tap
# Install: brew install jazzjackrabbit/tap/ihistory

class Ihistory < Formula
  desc 'A minimal, fast, fuzzy shell history search tool'
  homepage 'https://github.com/jazzjackrabbit/ihistory'
  version '0.1.0'
  license 'MIT'

  on_macos do
    on_arm do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-aarch64-apple-darwin.tar.gz"
      sha256 '8ab9d49eb8afe49180309ff7bd80bb8d657adb7dded1af9ae7d6cf17c89e84e2'
    end

    on_intel do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-x86_64-apple-darwin.tar.gz"
      sha256 '148f0521bc2bc8b7d29e4596b7b07053743e1f388ae9d1d3cd34a8fb325af396'
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-aarch64-unknown-linux-gnu.tar.gz"
      sha256 '4521c66ba6cc1c6c016b037002ee5ffe1dc65ef2f9d382d2c6e1b22cd2c4dfb3'
    end

    on_intel do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-x86_64-unknown-linux-gnu.tar.gz"
      sha256 '77f35161b65474c5f687e876f42cafd91e67c7e1c75ebde43ec67570ae54b2f5'
    end
  end

  def install
    bin.install 'ihistory'
    bin.install_symlink 'ihistory' => 'ih'
  end


  test do
    assert_match version.to_s, shell_output("#{bin}/ihistory --version")
  end
end
