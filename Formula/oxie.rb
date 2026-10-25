class Oxie < Formula
  desc "Command line tool and language server for the Oxie programming language"
  homepage "https://oxie.bkymz.net"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.4.0/oxie-aarch64-apple-darwin.tar.xz"
      sha256 "b3259cb2c8d8b5ec4971f9e98c74a94c2b668119ae790effaed87471091c6e23"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.4.0/oxie-x86_64-apple-darwin.tar.xz"
      sha256 "9a3b68781e7c7f69b1c2d451e3ca9bd5c695cb186eb9ae3afea30058d18cca02"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.4.0/oxie-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e7602eaf4e9d10a80932f5af3dc4d87f29c808ed231ca20032a6c5f33094c9e0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.4.0/oxie-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a10385c573377f759203561052613cd36ceaaf844a98c9abedc8aefe9a74210d"
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
