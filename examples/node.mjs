// Telegram Channel Scraper - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// Posts from the past week with 100K+ views
const run = await client.actor('Turboextract/telegram-channel-scraper').call({
    "channels": [
        "durov"
    ],
    "postedWithinDays": 7,
    "minViews": 100000
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.date, item.views, item.url);
}
