defmodule HackerNewsAggregator.PubSub do
  def subscribe(topic), do: Phoenix.PubSub.subscribe(__MODULE__, topic)

  def publish(payload, topic, metadata \\ %{}) do
    Phoenix.PubSub.broadcast(__MODULE__, topic, %{
      topic: topic,
      payload: payload,
      metadata: metadata
    })
  end
end
