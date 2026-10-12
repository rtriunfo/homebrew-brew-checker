class BrewChecker < Formula
  desc "Reconcile installed Homebrew casks against your Applications folder"
  homepage "https://github.com/rtriunfo/brew-checker"
  url "https://github.com/rtriunfo/brew-checker/releases/download/v0.2.1/brew-checker.py", using: :nounzip
  sha256 "0e5b41b82d6c66283a805caba05400a5d61828a9f82b63442af8c7aab2ef1a9a"
  license "MIT"
  version "0.2.1"

  # Run on a pinned interpreter rather than whatever `python3` is first on PATH
  # (on stock macOS that's the Command Line Tools' 3.9). The release workflow
  # smoke-tests the binaries on this same version, read from this line.
  depends_on "python@3.15"

  resource "brew-checker-tui" do
    url "https://github.com/rtriunfo/brew-checker/releases/download/v0.2.1/brew-checker-tui", using: :nounzip
    sha256 "6c9bd224878aa84234670e72703b8dc331680b0af827770d9f452ce57204657f"
  end

  def install
    libexec.install "brew-checker.py"
    resource("brew-checker-tui").stage { libexec.install "brew-checker-tui" }

    python = Formula["python@3.15"].opt_bin/"python3.15"
    { "brew-checker" => "brew-checker.py", "brew-checker-tui" => "brew-checker-tui" }.each do |cmd, target|
      (bin/cmd).write <<~SH
        #!/bin/bash
        exec "#{python}" "#{libexec}/#{target}" "$@"
      SH
      chmod 0755, bin/cmd
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/brew-checker --version")
    assert_match version.to_s, shell_output("#{bin}/brew-checker-tui --version")
  end
end
