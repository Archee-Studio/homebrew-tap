cask "archee-desktop" do
  arch arm: "arm64", intel: "x64"

  version "13.134.1"
  sha256 arm:   "bc11460c29436a4c65c2f0a090b4782efe4c141ec98ac4b6a125293440ac199f",
         intel: "5e12558c1a98642de8c4b811d5b9be962e079be68eedc4b6465d9e849f1f55e5"

  url "https://github.com/Archee-Studio/archee-desktop/releases/download/v#{version}/Archee-Studio-mac-#{arch}.dmg"
  name "Archee Studio"
  desc "Desktop app for Archee Studio"
  homepage "https://archee.studio/"

  depends_on macos: ">= :ventura"

  app "Archee Studio.app"
end
