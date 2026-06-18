#!/bin/bash
# Build and deploy XRewards admin dashboard to Firebase Hosting
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WEB_DIR="$SCRIPT_DIR/.."
REPO_ROOT="$SCRIPT_DIR/../.."

cd "$WEB_DIR"
npm install
npm run build

cd "$REPO_ROOT"
firebase deploy --only hosting --project xrewards-c0524
