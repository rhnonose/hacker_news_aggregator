defmodule HackerNewsAggregator.Fetcher.Builder do
  alias HackerNewsAggregator.Fetcher.Client

  def top(number) do
    "/v0/topstories"
    |> Client.get()
    # TODO(?): filter types
    |> take(number)
    |> Enum.map(&fetch_item/1)
    # TODO: handle deleted items
    |> Enum.map(fn {:ok, %{body: body}} -> body end)
  end

  # TODO: handle request errors
  defp take({:ok, %{body: body}}, number) do
    body
    |> Jason.decode!()
    |> Enum.take(number)
  end

  # TODO: use Task.async (mocks make it dificult to test)
  defp fetch_item(item_id), do: Client.get("/v0/item/#{item_id}")
end
