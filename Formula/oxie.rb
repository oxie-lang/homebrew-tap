class Oxie < Formula
  desc "Command line tool and language server for the Oxie programming language"
  homepage "https://oxie.bkymz.net"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.6.0/oxie-aarch64-apple-darwin.tar.xz"
      sha256 "d9ee7461faa195559d482678e66675055b04cde0045dfe22cb9c0fc4de9e0b04"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.6.0/oxie-x86_64-apple-darwin.tar.xz"
      sha256 "b9b5b5cbbe7f8d8b2bc4f35ac71b3d0bf93d880f1104950c83876a21bbdb7943"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.6.0/oxie-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5c5ec2ca2138bef356f305e5cda691843c7ab4fa1ba8ab1e28446687e7c40490"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.6.0/oxie-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "62b26d31088254fe615ffbba1998eb28af9d8b45aa003ba2a4612112bd32d861"
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
