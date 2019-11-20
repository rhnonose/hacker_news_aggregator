defmodule HackerNewsAggregator.Fetcher.Client do
  @moduledoc """
  HackerNews API client: https://github.com/HackerNews/API
  """
  @http_clint Application.get_env(:hacker_news_aggregator, :http_client, HTTPoison)
  @host Application.get_env(:hacker_news_aggregator, :host)

  def get(path) do
    path
    |> build_uri()
    |> @http_clint.get()
  end

  defp build_uri(path) do
    %URI{
      host: @host,
      path: path,
      scheme: "https"
    }
  end
end
