defmodule HackerNewsAggregator.Fetcher.Builder do
  alias HackerNewsAggregator.Fetcher.Client

  def top(number) do
    "/v0/topstories"
    |> Client.get()
    |> take(number)
    |> Enum.map(&fetch_item/1)
    |> Enum.map(fn {:ok, %{body: body}} -> body end)
  end

  defp take({:ok, %{body: body}}, number) do
    body
    |> Jason.decode!()
    |> Enum.take(number)
  end

  defp fetch_item(item_id), do: Client.get("/v0/item/#{item_id}")
end
