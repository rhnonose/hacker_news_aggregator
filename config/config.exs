use Mix.Config

config :hacker_news_aggregator, HackerNewsAggregatorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "l/r6+kgJRnW+eBawNWEkE5sM3EhAFYwA9eNvGb541yIMAQC7waEpRHHGvJ8UMVzM",
  render_errors: [view: HackerNewsAggregatorWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: HackerNewsAggregator.PubSub, adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
