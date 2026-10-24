class Oxie < Formula
  desc "Command line tool and language server for the Oxie programming language"
  homepage "https://oxie.bkymz.net"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.2.0/oxie-aarch64-apple-darwin.tar.xz"
      sha256 "088658ea613bcc71e5f954646f78b5fe5ce891d8fb97685c3b00357184658920"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.2.0/oxie-x86_64-apple-darwin.tar.xz"
      sha256 "51cc5856f744e8bfc58204b481ca7b2336893147e83b7b18d4ef8caaa9e21749"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.2.0/oxie-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "913ccede33ce8c629a5f4fc60e3ad42abc78eb66664b38020a84c78d6342c191"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.2.0/oxie-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f36f23cc77d4ac469286fbdc2b51e166b40b313f93517e39822d71c48d1a9c74"
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
