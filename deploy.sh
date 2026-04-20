#!/bin/bash
set -e

echo "Building..."
npm run build

echo "Deploying to Cloudflare Pages..."
npx wrangler pages deploy ./dist

echo "Done."
