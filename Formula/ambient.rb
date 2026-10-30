class Ambient < Formula
  desc "Rotating terminal dashboard: time, weather, net, crypto, system, events"
  homepage "https://github.com/subimageLLC/ambient"
  version "0.2.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/subimageLLC/ambient/releases/download/v0.2.0/ambient_0.2.0_darwin_amd64.tar.gz"
      sha256 "251346a6a158528606d8063785df80f70ebe7da15dd0d9fa00032d7f446cf3af"
    else
      url "https://github.com/subimageLLC/ambient/releases/download/v0.2.0/ambient_0.2.0_darwin_arm64.tar.gz"
      sha256 "0952eb1f126a1e1ef4c8cb92ad9f02665017d8b8ae33d64477ca7388660644a4"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/subimageLLC/ambient/releases/download/v0.2.0/ambient_0.2.0_linux_amd64.tar.gz"
      sha256 "db632a6aece2663fa223f119474fa5fb30bd98bd085290899a46138f64db2fe2"
    else
      url "https://github.com/subimageLLC/ambient/releases/download/v0.2.0/ambient_0.2.0_linux_arm64.tar.gz"
      sha256 "e14f500c20661db59c50fdcad33fbae0c7c6d300bcf304afb8b2f25bf967175d"
    end
  end

  # screen needs from screens/*/manifest.toml: now(toilet jq) net(gping)
  # coins(python3) sys(btop) sec(jq); core needs tmux. docker/tailscale/
  # journal hosts are opt-in services, deliberately not formula deps.
  depends_on "tmux"
  depends_on "jq"
  depends_on "toilet"
  depends_on "gping"
  depends_on "python@3"
  depends_on "btop"

  def install
    bin.install "ambient"
  end

  def caveats
    <<~EOS
      Run `ambient start` to build the session and attach (Ctrl-b d detaches).
      `ambient doctor` checks terminal, fonts, and every screen's needs.
    EOS
  end

  test do
    assert_match "ambient", shell_output("#{bin}/ambient version")
  end
end
