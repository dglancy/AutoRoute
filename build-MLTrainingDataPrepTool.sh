#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

xcodebuild build \
  -project Driveline.xcodeproj \
  -scheme MLTrainingDataPrepTool \
  -configuration Release \
  -destination 'platform=macOS' \
  -derivedDataPath build

mkdir -p ~/bin
cp build/Build/Products/Release/MLTrainingDataPrepTool ~/bin/MLTrainingDataPrepTool

echo "Installed to ~/bin/MLTrainingDataPrepTool"
echo "Make sure ~/bin is on your PATH (e.g. add 'export PATH=\"\$HOME/bin:\$PATH\"' to your shell profile)."
