#!/usr/bin/env bash

set -e

url="$1"

if [ -z "$url" ]; then
    echo "Usage: tst-sh <git-url>"
    exit 1
fi

workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT

parser_dir="$HOME/.config/nvim/parser"
query_dir="$HOME/.config/nvim/queries"

mkdir -p "$parser_dir"
mkdir -p "$query_dir"

echo "[1/7] Temp dir: $workdir"

cd "$workdir"

echo "[2/7] Cloning repo..."
git clone "$url"

repo=$(basename "$url" .git)

echo "[3/7] Entering repo: $repo"
cd "$repo"

echo "[4/7] Generating parser..."
tree-sitter generate

echo "[5/7] Building parser..."
tree-sitter build

sofile=$(find . -name "*.so" | head -n1)

if [ -z "$sofile" ]; then
    echo "No .so file found"
    exit 1
fi

lang=$(basename "$sofile" .so)

echo "[6/7] Installing parser: $lang"
cp "$sofile" "$parser_dir/$lang.so"

if [ -d queries ]; then
    echo "[7/7] Installing queries..."
    cp -r queries "$query_dir/$lang"
else
    echo "[7/7] No queries directory found."
fi

echo "Done: $lang installed"
