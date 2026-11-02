<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="arXiv Scraper API by Piloterr – scrape arXiv data as JSON" width="100%"></a>
</p>

# arXiv Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr arXiv Scraper API** lets you extract public data from arXiv as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **arXiv Paper API** — Fetch one arXiv paper by id or by an abs, pdf, or html URL.
- **arXiv Search API** — Search arXiv papers by keyword, author query such as au:einstein, or arXiv id.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [arXiv Paper API](#arxiv-paper-api) | `/v2/arxiv/paper` | 1 | Fetch one arXiv paper by id or by an abs, pdf, or html URL. |
| [arXiv Search API](#arxiv-search-api) | `/v2/arxiv/search` | 1 | Search arXiv papers by keyword, author query such as au |

## Table of contents

- [How it works](#how-it-works)
- [arXiv Paper API](#arxiv-paper-api)
- [arXiv Search API](#arxiv-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## arXiv Paper API

Fetch one arXiv paper by id or by an abs, pdf, or html URL.

`GET | POST https://api.piloterr.com/v2/arxiv/paper` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. arXiv id or an abs, pdf, or html URL. Example: 2201.00978 or https://arxiv.org/abs/cond-mat/0011267v1. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/arxiv/paper",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "2201.00978 or https://arxiv.org/abs/cond-mat/0011267v1.",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type ArxivPaper = {
  doi?: unknown;
  url?: string;
  title?: string;
  authors?: {
    name?: string;
    affiliation?: unknown;
  }[];
  comment?: string;
  pdf_url?: string;
  updated?: string;
  version?: number;
  abstract?: string;
  arxiv_id?: string;
  published?: string;
  categories?: string[];
  journal_ref?: string;
  primary_category?: string;
};

const params = new URLSearchParams({
  "query": "2201.00978 or https://arxiv.org/abs/cond-mat/0011267v1.",
});

const response = await fetch(`https://api.piloterr.com/v2/arxiv/paper?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as ArxivPaper;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/arxiv/paper
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "2201.00978 or https://arxiv.org/abs/cond-mat/0011267v1."}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "doi": null,
  "url": "https://arxiv.org/abs/cond-mat/0011267v1",
  "title": "The electronic structure of cuprates from high energy spectroscopy",
  "authors": [
    {
      "name": "example",
      "affiliation": null
    },
    {
      "name": "example",
      "affiliation": null
    }
  ],
  "comment": "J. Electron Spec. Relat. Phenom.: special issue on electron correlation, in press",
  "pdf_url": "https://arxiv.org/pdf/cond-mat/0011267v1",
  "updated": "2000-11-15T16:19:15Z",
  "version": 1,
  "abstract": "We report studies of the electronic structure and elementary excitations of doped and undoped cuprate chains, ladders and planes. Using h…",
  "arxiv_id": "cond-mat/0011267",
  "published": "2000-11-15T16:19:15Z",
  "categories": [
    "cond-mat.supr-con",
    "cond-mat.str-el"
  ],
  "journal_ref": "J. Electron Spectr. Relat. Phenom. 117-118, 203 (2001)",
  "primary_category": "cond-mat.supr-con"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `doi` | object |  |
| `url` | string |  |
| `title` | string |  |
| `authors[]` | object[] |  |
| `authors[].name` | string |  |
| `authors[].affiliation` | object |  |
| `comment` | string |  |
| `pdf_url` | string |  |
| `updated` | string |  |
| `version` | integer |  |
| `abstract` | string |  |
| `arxiv_id` | string |  |
| `published` | string |  |
| `categories` | string[] |  |
| `journal_ref` | string |  |
| `primary_category` | string |  |

## arXiv Search API

Search arXiv papers by keyword, author query such as au:einstein, or arXiv id. A paper URL returns 400. Page through results when the match count is large.

`GET | POST https://api.piloterr.com/v2/arxiv/search` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. Keyword, fielded query such as au:einstein, arXiv id, or an arxiv.org search URL. Example: electron. A paper URL such as https://arxiv.org/abs/2201.00978 returns 400. |
| `page` | number | — | Optional. Page number from 1. Example: 2. Defaults to 1. Each page has 10 papers. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/arxiv/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "electron. A paper URL such as https://arxiv.org/abs/2201.00978 returns 400.",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type ArxivSearch = {
  results?: {
    doi?: unknown;
    url?: string;
    title?: string;
    authors?: {
      name?: string;
      affiliation?: unknown;
    }[];
    comment?: string;
    pdf_url?: string;
    updated?: string;
    version?: number;
    abstract?: string;
    arxiv_id?: string;
    published?: string;
    categories?: string[];
    journal_ref?: string;
    primary_category?: string;
  }[];
  pagination?: {
    next?: string;
    page?: number;
    per_page?: number;
    total_pages?: number;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "electron. A paper URL such as https://arxiv.org/abs/2201.00978 returns 400.",
});

const response = await fetch(`https://api.piloterr.com/v2/arxiv/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as ArxivSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/arxiv/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "electron. A paper URL such as https://arxiv.org/abs/2201.00978 returns 400."}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "doi": null,
      "url": "https://arxiv.org/abs/cond-mat/0011267v1",
      "title": "The electronic structure of cuprates from high energy spectroscopy",
      "authors": [
        {},
        {}
      ],
      "comment": "J. Electron Spec. Relat. Phenom.: special issue on electron correlation, in press",
      "pdf_url": "https://arxiv.org/pdf/cond-mat/0011267v1",
      "updated": "2000-11-15T16:19:15Z",
      "version": 1,
      "abstract": "We report studies of the electronic structure and elementary excitations of doped and undoped cuprate chains, ladders and planes. Using h…",
      "arxiv_id": "cond-mat/0011267",
      "published": "2000-11-15T16:19:15Z",
      "categories": [
        "cond-mat.supr-con",
        "cond-mat.str-el"
      ],
      "journal_ref": "J. Electron Spectr. Relat. Phenom. 117-118, 203 (2001)",
      "primary_category": "cond-mat.supr-con"
    }
  ],
  "pagination": {
    "next": "https://arxiv.org/search/?searchtype=all&query=electron&start=10",
    "page": 1,
    "per_page": 10,
    "total_pages": 18823,
    "total_results": 188230
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].doi` | object |  |
| `results[].url` | string |  |
| `results[].title` | string |  |
| `results[].authors[]` | object[] |  |
| `results[].comment` | string |  |
| `results[].pdf_url` | string |  |
| `results[].updated` | string |  |
| `results[].version` | integer |  |
| `results[].abstract` | string |  |
| `results[].arxiv_id` | string |  |
| `results[].published` | string |  |
| `results[].categories` | string[] |  |
| `results[].journal_ref` | string |  |
| `results[].primary_category` | string |  |
| `pagination` | object |  |
| `pagination.next` | string |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |
| `pagination.total_pages` | integer |  |
| `pagination.total_results` | integer |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Paper | Search |
|---|---|---|
| cURL (Bash) | [`paper`](examples/curl/paper.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`paper`](examples/php/paper.php) | [`search`](examples/php/search.php) |
| C# | [`paper`](examples/csharp/Paper.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`paper`](examples/go/paper.go) | [`search`](examples/go/search.go) |
| Java | [`paper`](examples/java/PaperExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`paper`](examples/ruby/paper.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`paper`](examples/nodejs/paper.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — arXiv plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape arXiv?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/arxiv/paper` **1**, `/v2/arxiv/search` **1**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the arXiv API return?

Each endpoint returns structured JSON: **arXiv Paper** — `doi`, `url`, `title`, `authors[]`, `authors[].name`, `authors[].affiliation`; **arXiv Search** — `results[]`, `results[].doi`, `results[].url`, `results[].title`, `results[].authors[]`, `results[].comment`.

### How do I paginate arXiv results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>arXiv is a trademark of its respective owner. This repository is not affiliated with or endorsed by arXiv. Examples are released under the MIT license.</sub>
