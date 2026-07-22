class BrewChecker < Formula
  desc "Reconcile installed Homebrew casks against your Applications folder"
  homepage "https://github.com/rtriunfo/brew-checker"
  url "https://github.com/rtriunfo/brew-checker/releases/download/v0.1.0/brew-checker.py", using: :nounzip
  sha256 "d17acab894923c360b4a80b4948b3329b43cc021ebe4ecd9732e73ec52062cd7"
  license "MIT"
  version "0.1.0"

  resource "brew-checker-tui" do
    url "https://github.com/rtriunfo/brew-checker/releases/download/v0.1.0/brew-checker-tui", using: :nounzip
    sha256 "84478731aab9a403aab17b629b2dccfd68ba52079a1759a3fcd265f740bbd1f8"
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
