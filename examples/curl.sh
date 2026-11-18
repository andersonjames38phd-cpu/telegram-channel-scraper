#!/usr/bin/env bash
# Telegram Channel Scraper - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~telegram-channel-scraper"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Last 50 posts from two channels (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "channels": [
      "durov",
      "telegram"
    ],
    "maxPostsPerChannel": 50
  }'

# 2. Posts from the past week with 100K+ views (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "channels": [
      "durov"
    ],
    "postedWithinDays": 7,
    "minViews": 100000
  }'

# 3. Keyword alert across channels (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "channels": [
      "https://t.me/telegram",
      "@durov"
    ],
    "keywords": [
      "stars",
      "ads"
    ],
    "maxPostsPerChannel": 200
  }'
