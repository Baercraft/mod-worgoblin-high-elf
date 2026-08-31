#!/usr/bin/env bash
set -euo pipefail
PATCH="$(cd "$(dirname "$0")/.." && pwd)/integration/mod-worgoblin-highelf-azerothcore.patch"
git apply --check "$PATCH"
git apply "$PATCH"
echo "Core custom-race patch applied."
