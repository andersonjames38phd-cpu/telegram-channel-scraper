"""Telegram Channel Scraper - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# Last 50 posts from two channels
run = client.actor("Turboextract/telegram-channel-scraper").call(run_input={
    "channels": [
        "durov",
        "telegram"
    ],
    "maxPostsPerChannel": 50
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("date"), item.get("views"), item.get("url"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
