use Mix.Config

config :hacker_news_aggregator, HackerNewsAggregatorWeb.Endpoint,
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info

config :hacker_news_aggregator,
  host: "hacker-news.firebaseio.com"

import_config "prod.secret.exs"
