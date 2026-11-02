#!/usr/bin/env bash
# arXiv Paper API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./paper.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/arxiv/paper" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode 'query=2201.00978 or https://arxiv.org/abs/cond-mat/0011267v1.'
