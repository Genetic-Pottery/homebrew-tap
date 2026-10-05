class Warlock < Formula
  desc "A terminal UI that keeps AI-readable documentation of a codebase current"
  homepage "https://github.com/Genetic-Pottery/warlock"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Genetic-Pottery/warlock/releases/download/v0.1.0/warlock-tui-aarch64-apple-darwin.tar.xz"
      sha256 "4104c5a04a958e323e058c2abdc6a60c554c744642a7b27070363fa6440bb92d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Genetic-Pottery/warlock/releases/download/v0.1.0/warlock-tui-x86_64-apple-darwin.tar.xz"
      sha256 "c0f308ab6d24b8133e004c7e3c40cb7cbeaf9f19381ad663ad6e696e9be1fef7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Genetic-Pottery/warlock/releases/download/v0.1.0/warlock-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ca00378bd7a29296793ea09e69165965cb00cc18de2422bba1a5cf04c8b7aabd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Genetic-Pottery/warlock/releases/download/v0.1.0/warlock-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bb1096785a068ef4c31c998fa0a87b7b16e91ea66ecc15c6788bbf0a5134c73c"
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
