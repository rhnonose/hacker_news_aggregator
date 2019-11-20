defmodule HackerNewsAggregator.Fetcher.ClientTest do
  use ExUnit.Case

  alias HackerNewsAggregator.Fetcher.Client

  describe "get" do
    test "get top stories" do
      assert {:ok, %{status_code: 200, body: "[1,2,3]"}} = Client.get("/v0/topstories.json")
    end

    test "get item" do
      assert {:ok, %{status_code: 200, body: _}} = Client.get("/v0/item/1.json")
    end
  end
end
