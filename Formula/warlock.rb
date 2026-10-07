class Warlock < Formula
  desc "A terminal UI that keeps AI-readable documentation of a codebase current"
  homepage "https://github.com/Genetic-Pottery/warlock"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Genetic-Pottery/warlock/releases/download/v0.1.2/warlock-tui-aarch64-apple-darwin.tar.xz"
      sha256 "8a5c33503e80ab6cb0fbfee0b6800e4dfd7e8a686fa1a9f1ee2f3619ebf011bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Genetic-Pottery/warlock/releases/download/v0.1.2/warlock-tui-x86_64-apple-darwin.tar.xz"
      sha256 "b519c4e41f2adc8a2de57841b5ec437be7a57413492e68565025c9bafde9a51c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Genetic-Pottery/warlock/releases/download/v0.1.2/warlock-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0b9f13eb334d3bb6cd728fdc46d9c5d41e95bf492028507f37b44b3d3b4264bd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Genetic-Pottery/warlock/releases/download/v0.1.2/warlock-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f52a6a339c177316bc169ade6ebd45cd7ecdc89d10973014af6bf6244c7bc068"
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
