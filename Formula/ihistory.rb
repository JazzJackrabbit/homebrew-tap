# Homebrew formula for ihistory
# Place this file at Formula/ihistory.rb in repo: homebrew-tap
# Install: brew install jazzjackrabbit/tap/ihistory

class Ihistory < Formula
  desc 'A minimal, fast, fuzzy shell history search tool'
  homepage 'https://github.com/jazzjackrabbit/ihistory'
  version '0.1.3_2'
  license 'MIT'

  on_macos do
    on_arm do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-aarch64-apple-darwin.tar.gz"
      sha256 'c0fac106247a15dd98ab33dd9c1bb10eb197095a920fc964a4d51d66c113c5a7'
    end

    on_intel do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-x86_64-apple-darwin.tar.gz"
      sha256 'ff188305792e7bf3da49a4fd74bb340d710798cb51496d4d6ca2f24f72205f32'
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-aarch64-unknown-linux-gnu.tar.gz"
      sha256 '9c8385764e78be8727c34aa3c30c86613169628bcaa12abff6d0b768e96569ab'
    end

    on_intel do
      url "https://github.com/jazzjackrabbit/ihistory/releases/download/v#{version}/ihistory-x86_64-unknown-linux-gnu.tar.gz"
      sha256 '94f9bba2c83d098cd367a2d455c782911aa204f0c679f2c920bacc76a0ac6479'
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
