class Oxie < Formula
  desc "Command line tool and language server for the Oxie programming language"
  homepage "https://oxie.bkymz.net"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.3.0/oxie-aarch64-apple-darwin.tar.xz"
      sha256 "09649eb5029c3e9809ca79bcf0fe10847370ac3907761c93876aa146a02bf1dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.3.0/oxie-x86_64-apple-darwin.tar.xz"
      sha256 "ed1c80f1900259db32a8cb8a27e73544fd6b9cb95a61700eb31d360e25bc4826"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.3.0/oxie-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d218b6905013ef9104c2b1cfe944d18836dd70193c347e9ccb3ed04de0d83932"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oxie-lang/oxie/releases/download/v0.3.0/oxie-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9245b01db42bb818713fe836c767248415ae50fd1de7d5d7266722dded7a7430"
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
