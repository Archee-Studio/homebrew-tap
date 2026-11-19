class ArcheeCli < Formula
  desc "Archee Studio command line: `archee`."
  homepage "https://archee.studio"
  version "16.46.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Archee-Studio/archee-cli/releases/download/v16.46.0/archee-cli-aarch64-apple-darwin.tar.xz"
      sha256 "34f48dd0da1660a98bb5782b6a486ac1dd75a1ac97cae3cf34c36647b7112358"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Archee-Studio/archee-cli/releases/download/v16.46.0/archee-cli-x86_64-apple-darwin.tar.xz"
      sha256 "9aaaa9b8cbb773f8ff134f7033ac5d7d69719c110fc3ee3ebc40eafc618705ec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Archee-Studio/archee-cli/releases/download/v16.46.0/archee-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "3db6cbf2e51423b4c1f4bd59fb97597cceea5904f910e84b56ab3f96557f3b8d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Archee-Studio/archee-cli/releases/download/v16.46.0/archee-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "c9993eab70482d365124682ec21e6c6abb521ea02cfc991991106503ea8763d3"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

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
      bin.install "archee"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "archee"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "archee"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "archee"
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
