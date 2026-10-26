class Oxie < Formula
  desc "Command line tool and language server for the Oxie programming language"
  homepage "https://oxie.bkymz.net"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.4.1/oxie-aarch64-apple-darwin.tar.xz"
      sha256 "8fb0162b3114440bbe580afe441965a3be2408d3eb3641fdb467924d2f637cd8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.4.1/oxie-x86_64-apple-darwin.tar.xz"
      sha256 "cc0618bce2f75ef32ffd6bc7cb2c5d70f06d9c865eac161485e57d2d8b7e45ef"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.4.1/oxie-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1d8bb86377e54f3655ab70e494451412c33c8d13a21f77b598667bc98c72cb96"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.4.1/oxie-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2e0bc4056ca4fd27614ed8d0f05ae7fc4b4fc6d348e316d2a29db1dce7d6bd8e"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "oxie"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "oxie"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "oxie"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "oxie"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
