class BrewChecker < Formula
  desc "Reconcile installed Homebrew casks against your Applications folder"
  homepage "https://github.com/rtriunfo/brew-checker"
  url "https://github.com/rtriunfo/brew-checker/releases/download/v0.1.1/brew-checker.py", using: :nounzip
  sha256 "a0c443a0352768fff0e8493c3a0abee63ff94f457a7095c71d6d88d319e80436"
  license "MIT"
  version "0.1.1"

  resource "brew-checker-tui" do
    url "https://github.com/rtriunfo/brew-checker/releases/download/v0.1.1/brew-checker-tui", using: :nounzip
    sha256 "4b375cc9c388dbb3625483befb8a8a97f65d53b3752b2e07c4fe5d43d1eeebf1"
  end

  def install
    bin.install "brew-checker.py" => "brew-checker"
    chmod 0755, bin/"brew-checker"

    resource("brew-checker-tui").stage do
      bin.install "brew-checker-tui"
      chmod 0755, bin/"brew-checker-tui"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/brew-checker --version")
    assert_match version.to_s, shell_output("#{bin}/brew-checker-tui --version")
  end
end
