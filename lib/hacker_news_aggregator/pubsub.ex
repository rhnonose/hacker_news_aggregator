defmodule HackerNewsAggregator.PubSub do
  def subscribe(topic), do: Phoenix.PubSub.subscribe(__MODULE__, topic)
end
