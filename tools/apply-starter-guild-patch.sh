#!/usr/bin/env sh
set -eu
ROOT="${1:-.}"
PATCH="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)/integration/mod-starter-guild-custom-races.patch"
cd "$ROOT"
git apply --check "$PATCH"
git apply "$PATCH"
echo "Starter Guild custom-race patch applied."
