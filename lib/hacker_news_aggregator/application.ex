defmodule HackerNewsAggregator.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      HackerNewsAggregatorWeb.Endpoint,
      supervisor(Phoenix.PubSub.PG2, [HackerNewsAggregator.PubSub, []])
    ]

    opts = [strategy: :one_for_one, name: HackerNewsAggregator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    HackerNewsAggregatorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
