defmodule HackerNewsAggregator.Fetcher.BuilderTest do
  use ExUnit.Case

  alias HackerNewsAggregator.Fetcher.Builder

  describe "top/0" do
    test "get top 3 items" do
      assert [%{"id" => 1}, %{"id" => 2}, %{"id" => 3}] = Builder.top(3)
    end
  end
end
