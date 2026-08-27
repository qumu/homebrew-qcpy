# homebrew-qcpy

Homebrew tap for the Qumu qcpy CLI formula.

## Install

```bash
brew tap qumu/qcpy
brew install qc
```

Tap source repository: `https://github.com/qumu/homebrew-qcpy`.

## Upgrade

```bash
brew update
brew upgrade qc
```

## Uninstall

```bash
brew uninstall qc
brew untap qumu/qcpy
```

## Maintainer Quick Update

1. Update version, URLs, and checksums in `Formula/qc.rb`.
2. Commit and push to this tap repository.
3. Users run `brew update && brew upgrade qc`.

## Artifact URL Pattern

The formula currently pulls binaries from Google Artifact Registry Generic repo:

- `https://europe-generic.pkg.dev/<gcp-project>/public/qcpy/<version>/qc-darwin-arm64`
- `https://europe-generic.pkg.dev/<gcp-project>/public/qcpy/<version>/qc-linux-amd64`
