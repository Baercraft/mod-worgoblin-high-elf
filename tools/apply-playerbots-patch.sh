#!/usr/bin/env bash
set -euo pipefail
PATCH="$(cd "$(dirname "$0")/.." && pwd)/integration/mod-worgoblin-highelf-playerbots.patch"
git apply --check "$PATCH"
git apply "$PATCH"
echo "Playerbots custom-race patch applied."
