use Mix.Config

config :hacker_news_aggregator, HackerNewsAggregatorWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime

config :hacker_news_aggregator,
  host: "hacker-news.firebaseio.com"
