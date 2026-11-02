#!/usr/bin/env bash
# arXiv Search API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./search.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/arxiv/search" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode 'query=electron. A paper URL such as https://arxiv.org/abs/2201.00978 returns 400.'
