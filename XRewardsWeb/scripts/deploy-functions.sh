#!/bin/bash
# Deploy XRewards admin Cloud Functions
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/../../../../KidsAdventure/adventure-platform-monorepo"
./deploy_xrewards_functions.sh
