defmodule HackerNewsAggregatorWeb.StoriesChannel do
  use HackerNewsAggregatorWeb, :channel

  def join("top_stories_fetched", _payload, socket) do
    send(self(), :send_after)
    {:ok, socket}
  end

  def handle_info(%{topic: "top_stories_fetched", payload: payload}, socket) do
    # clean_payload = Enum.map(payload, fn {_id, body} -> body end)

    push(socket, "top_stories_fetched", %{data: payload})

    {:noreply, socket}
  end

  def handle_info(:send_after, socket) do
    push(socket, "top_stories_fetched", %{
      data: HackerNewsAggregator.Stories.index()
    })

    {:noreply, socket}
  end

  def handle_info(_, socket) do
    {:noreply, socket}
  end
end
