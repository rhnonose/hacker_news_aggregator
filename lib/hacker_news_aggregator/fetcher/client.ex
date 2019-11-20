defmodule HackerNewsAggregator.Fetcher.Client do
  @moduledoc """
  HackerNews API client: https://github.com/HackerNews/API
  """
  require Mockery.Macro

  @host Application.get_env(:hacker_news_aggregator, :host)

  def get(path) do
    path
    |> build_uri()
    |> http_client().get()
  end

  defp build_uri(path) do
    %URI{
      host: @host,
      path: path,
      scheme: "https"
    }
  end

  defp http_client, do: Mockery.Macro.mockable(HTTPoison)
end
