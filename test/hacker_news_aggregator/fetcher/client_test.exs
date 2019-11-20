defmodule HackerNewsAggregator.Fetcher.ClientTest do
  use ExUnit.Case

  import Mockery
  import Mockery.Assertions

  alias HackerNewsAggregator.Fetcher.Client

  @topstories_uri %URI{
    path: "/v0/topstories",
    scheme: "https",
    host: "example.com"
  }

  @item_uri %URI{
    path: "/v0/item/1",
    scheme: "https",
    host: "example.com"
  }

  @item %{
    "by" => "tel",
    "descendants" => 16,
    "id" => 1,
    "kids" => [2, 2, 3],
    "score" => 25,
    "text" => "some text",
    "time" => 1_203_647_620,
    "title" => "some title",
    "type" => "story"
  }

  describe "get" do
    test "get top stories" do
      mock(HTTPoison, :get, {:ok, %{status_code: 200, body: "[1,2,3]"}})

      uri = @topstories_uri

      assert {:ok, %{status_code: 200, body: "[1,2,3]"}} = Client.get("/v0/topstories")
      assert_called(HTTPoison, :get, [^uri])
    end

    test "get item" do
      mock(HTTPoison, :get, {:ok, %{status_code: 200, body: @item}})

      uri = @item_uri
      item = @item

      assert {:ok, %{status_code: 200, body: ^item}} = Client.get("/v0/item/1")
      assert_called(HTTPoison, :get, [^uri])
    end
  end
end
