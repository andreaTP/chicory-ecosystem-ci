#!/bin/bash

# Path to local Maven repository (change if your repo is in a different location)
M2_REPO="$HOME/.m2/repository"
GROUP_PATH="com/dylibso/chicory"

# Full path to the group directory
TARGET_DIR="$M2_REPO/$GROUP_PATH"

# Check if the directory exists
if [ ! -d "$TARGET_DIR" ]; then
  echo "No local artifacts found for com.dylibso.chicory"
  exit 0
fi

# Find all versions that are NOT 999-SNAPSHOT
echo "Checking for non-999-SNAPSHOT versions under $TARGET_DIR"
INVALID_VERSIONS=$(find "$TARGET_DIR" -mindepth 2 -type d \
  | grep -v '/999-SNAPSHOT$')

if [ -z "$INVALID_VERSIONS" ]; then
  echo "✅ No invalid versions found. Only 999-SNAPSHOT is present."
  exit 0
else
  echo "❌ Found artifacts with versions other than 999-SNAPSHOT:"
  echo "$INVALID_VERSIONS"
  exit 1
fi
