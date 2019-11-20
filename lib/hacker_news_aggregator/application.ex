defmodule HackerNewsAggregator.Application do
  @moduledoc false
  use Application

  import Supervisor.Spec

  def start(_type, _args) do
    children =
      [
        HackerNewsAggregatorWeb.Endpoint
      ] ++ runtime_children(Mix.env())

    opts = [strategy: :one_for_one, name: HackerNewsAggregator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    HackerNewsAggregatorWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp runtime_children(:test), do: []

  defp runtime_children(_),
    do: [
      worker(HackerNewsAggregator.Storer, []),
      worker(HackerNewsAggregator.Fetcher, [])
    ]
end
