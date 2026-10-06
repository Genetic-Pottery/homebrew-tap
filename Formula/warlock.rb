class Warlock < Formula
  desc "A terminal UI that keeps AI-readable documentation of a codebase current"
  homepage "https://github.com/Genetic-Pottery/warlock"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Genetic-Pottery/warlock/releases/download/v0.1.1/warlock-tui-aarch64-apple-darwin.tar.xz"
      sha256 "49b065e7cb5337a7661db705901bdd56aacb95c115ec4b91b2ae0a99122ae3c5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Genetic-Pottery/warlock/releases/download/v0.1.1/warlock-tui-x86_64-apple-darwin.tar.xz"
      sha256 "e9f2c90264107c6b2b4ddf5bb77f833e27f6cb340a4061e353ce2f432520556c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Genetic-Pottery/warlock/releases/download/v0.1.1/warlock-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "410de67bbb385b5a51fc6cce3bbbf14e343de7f03391ca3abf3d691150282183"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Genetic-Pottery/warlock/releases/download/v0.1.1/warlock-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "245b82d7fc0f0f5a27d8862458ee96af363f6ac8224543472390ba90689a316c"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
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
      bin.install "warlock"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "warlock"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "warlock"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "warlock"
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
