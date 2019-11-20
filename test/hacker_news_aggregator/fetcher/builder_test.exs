defmodule HackerNewsAggregator.Fetcher.BuilderTest do
  use ExUnit.Case

  import Mockery
  import Mockery.Assertions

  alias HackerNewsAggregator.Fetcher.Builder

  @topstories_uri %URI{
    path: "/v0/topstories",
    scheme: "https",
    host: "example.com"
  }

  @uri1 %URI{
    path: "/v0/item/1",
    scheme: "https",
    host: "example.com"
  }

  @uri2 %URI{
    path: "/v0/item/2",
    scheme: "https",
    host: "example.com"
  }

  @uri3 %URI{
    path: "/v0/item/3",
    scheme: "https",
    host: "example.com"
  }

  describe "top/0" do
    test "get top 3 items" do
      topstories_uri = @topstories_uri
      uri1 = @uri1
      uri2 = @uri2
      uri3 = @uri3

      mock(HTTPoison, [get: 1], fn
        %URI{path: "/v0/topstories"} ->
          {:ok, %{status_code: 200, body: "[1,2,3]"}}

        %URI{path: "/v0/item/" <> id} ->
          {id_int, ""} = Integer.parse(id)

          {:ok,
           %{
             status_code: 200,
             body: %{
               "by" => "tel",
               "descendants" => 0,
               "id" => id_int,
               "kids" => [],
               "score" => 25,
               "text" => "some text",
               "time" => 1_203_647_620,
               "title" => "some title",
               "type" => "story"
             }
           }}
      end)

      assert [%{"id" => 1}, %{"id" => 2}, %{"id" => 3}] = Builder.top(3)

      assert_called(HTTPoison, :get, [^topstories_uri])
      assert_called(HTTPoison, :get, [^uri1])
      assert_called(HTTPoison, :get, [^uri2])
      assert_called(HTTPoison, :get, [^uri3])
    end
  end
end
