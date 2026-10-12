class BrewChecker < Formula
  desc "Reconcile installed Homebrew casks against your Applications folder"
  homepage "https://github.com/rtriunfo/brew-checker"
  url "https://github.com/rtriunfo/brew-checker/releases/download/v0.2.0/brew-checker.py", using: :nounzip
  sha256 "f6b808ae1a21c333cadc8bc94e48e28fdd4e69f0c54d91b85469fd1ea1c754e0"
  license "MIT"
  version "0.2.0"

  resource "brew-checker-tui" do
    url "https://github.com/rtriunfo/brew-checker/releases/download/v0.2.0/brew-checker-tui", using: :nounzip
    sha256 "8de8ac24656f9c047e20ff5120baa8e6a3cb6ee6b7ceff920f62db10c0d4f8ae"
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
