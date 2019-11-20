defmodule HackerNewsAggregator.Fetcher do
  @moduledoc """
  GenServer responsible for periodically fetching top stories from hacker news
  """
  use GenServer

  alias HackerNewsAggregator.{
    Fetcher.Builder,
    PubSub
  }

  @fetch_period Application.get_env(:hacker_news_aggregator, :fetch_period, 300_000)

  @spec start_link :: GenServer.start_link()
  def start_link, do: GenServer.start_link(__MODULE__, [], name: __MODULE__)

  @spec init(term) :: {:ok, term}
  def init(_), do: {:ok, [], {:continue, :fetch}}

  def handle_continue(:fetch, state) do
    50
    |> Builder.top()
    |> PubSub.publish("top_stories_fetched")

    :timer.send_interval(@fetch_period, self(), :fetch)

    {:noreply, state}
  end

  def handle_info(:fetch, state) do
    50
    |> Builder.top()
    |> PubSub.publish("top_stories_fetched")

    {:noreply, state}
  end
end
