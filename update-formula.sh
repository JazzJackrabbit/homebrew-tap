#!/bin/bash
set -e

if [[ -z "$1" ]]; then
  echo "Usage: $0 <project> [version]"
  echo "Example: $0 ihistory 0.1.2"
  exit 1
fi

PROJECT="$1"
REPO="jazzjackrabbit/$PROJECT"
FORMULA="Formula/$PROJECT.rb"

if [[ ! -f "$FORMULA" ]]; then
  echo "Error: $FORMULA not found"
  exit 1
fi

# Get version from arg or fetch latest
if [[ -n "$2" ]]; then
  VERSION="$2"
else
  VERSION=$(gh release view --repo "$REPO" --json tagName -q '.tagName' | sed 's/^v//')
fi

echo "Updating $PROJECT formula to version $VERSION"

# Base URL for downloads
BASE_URL="https://github.com/$REPO/releases/download/v$VERSION"

# Fetch SHA256 for each target
echo "Fetching SHA256 checksums..."

SHA_AARCH64_DARWIN=$(curl -sL "$BASE_URL/$PROJECT-aarch64-apple-darwin.tar.gz" | shasum -a 256 | cut -d' ' -f1)
echo "  aarch64-apple-darwin: $SHA_AARCH64_DARWIN"

SHA_X86_64_DARWIN=$(curl -sL "$BASE_URL/$PROJECT-x86_64-apple-darwin.tar.gz" | shasum -a 256 | cut -d' ' -f1)
echo "  x86_64-apple-darwin:  $SHA_X86_64_DARWIN"

SHA_AARCH64_LINUX=$(curl -sL "$BASE_URL/$PROJECT-aarch64-unknown-linux-gnu.tar.gz" | shasum -a 256 | cut -d' ' -f1)
echo "  aarch64-linux-gnu:    $SHA_AARCH64_LINUX"

SHA_X86_64_LINUX=$(curl -sL "$BASE_URL/$PROJECT-x86_64-unknown-linux-gnu.tar.gz" | shasum -a 256 | cut -d' ' -f1)
echo "  x86_64-linux-gnu:     $SHA_X86_64_LINUX"

# Update version and SHA256s in formula
echo "Updating $FORMULA..."

# Update version
sed -i '' "s/version '[^']*'/version '$VERSION'/" "$FORMULA"

# Update SHA256s in order they appear in the file
# 1. aarch64-apple-darwin (macOS ARM)
# 2. x86_64-apple-darwin (macOS Intel)
# 3. aarch64-unknown-linux-gnu (Linux ARM)
# 4. x86_64-unknown-linux-gnu (Linux Intel)
awk -v sha1="$SHA_AARCH64_DARWIN" \
    -v sha2="$SHA_X86_64_DARWIN" \
    -v sha3="$SHA_AARCH64_LINUX" \
    -v sha4="$SHA_X86_64_LINUX" '
{
  if (/sha256/ && !done1) { sub(/sha256 .*/, "sha256 \047" sha1 "\047"); done1=1 }
  else if (/sha256/ && !done2) { sub(/sha256 .*/, "sha256 \047" sha2 "\047"); done2=1 }
  else if (/sha256/ && !done3) { sub(/sha256 .*/, "sha256 \047" sha3 "\047"); done3=1 }
  else if (/sha256/ && !done4) { sub(/sha256 .*/, "sha256 \047" sha4 "\047"); done4=1 }
  print
}' "$FORMULA" > "$FORMULA.tmp" && mv "$FORMULA.tmp" "$FORMULA"

echo "Done! Formula updated to $VERSION"
echo ""
echo "To complete the update:"
echo "  git add $FORMULA"
echo "  git commit -m '$PROJECT $VERSION'"
echo "  git push"
