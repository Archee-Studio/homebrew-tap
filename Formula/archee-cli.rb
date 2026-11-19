class ArcheeCli < Formula
  desc "Archee Studio command line: `archee`."
  homepage "https://archee.studio"
  version "13.128.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Archee-Studio/archee-cli/releases/download/v13.128.0/archee-cli-aarch64-apple-darwin.tar.xz"
      sha256 "767b6d6135b3d8de2c4d7e02a82460fef313b22316f2bafb6c565840ecb2e5c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Archee-Studio/archee-cli/releases/download/v13.128.0/archee-cli-x86_64-apple-darwin.tar.xz"
      sha256 "6d49f27fce09459036bc2ef287e3b5f40ffcf63a7dae2e23634aec33434f4c93"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Archee-Studio/archee-cli/releases/download/v13.128.0/archee-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "d52b9d9ab29645544d3342707923218572709754c2740d2bbb1165ac68eb05b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Archee-Studio/archee-cli/releases/download/v13.128.0/archee-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "b02c6d1940068caae833d42f693c7d73fc891ab3a55235b29f69f985c44375ee"
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
