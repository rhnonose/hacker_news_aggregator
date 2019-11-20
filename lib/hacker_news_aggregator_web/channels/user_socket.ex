defmodule HackerNewsAggregatorWeb.UserSocket do
  use Phoenix.Socket

  channel "top_stories_fetched", HackerNewsAggregatorWeb.StoriesChannel

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
