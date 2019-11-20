use Mix.Config

config :hacker_news_aggregator, HackerNewsAggregatorWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn

config :hacker_news_aggregator,
  host: "example.com",
  http_client: HackerNewsAggregator.HttpMock
