class Ambient < Formula
  desc "Rotating terminal dashboard: time, weather, net, crypto, system, events"
  homepage "https://github.com/subimageLLC/ambient"
  version "0.2.1"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/subimageLLC/ambient/releases/download/v0.2.1/ambient_0.2.1_darwin_amd64.tar.gz"
      sha256 "d67c3492c9a5fcc223c13869d47b89123495bd4bbb5858f79a0164fde4571b87"
    else
      url "https://github.com/subimageLLC/ambient/releases/download/v0.2.1/ambient_0.2.1_darwin_arm64.tar.gz"
      sha256 "a550452488f818dc576e3bf2e80216caa8da5370d1e3ceeac797c7885a9e1c6f"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/subimageLLC/ambient/releases/download/v0.2.1/ambient_0.2.1_linux_amd64.tar.gz"
      sha256 "c3f3373902af543600d0db77360cddbf16e51a4cbfa56cc0587e9d2c4ffd7f81"
    else
      url "https://github.com/subimageLLC/ambient/releases/download/v0.2.1/ambient_0.2.1_linux_arm64.tar.gz"
      sha256 "d509f85f777b3daf8850ad5ca0aa735a42c3257ad9af12e8a932e97007f2a943"
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
