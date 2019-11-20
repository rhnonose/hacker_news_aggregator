defmodule HackerNewsAggregator.FetcherTest do
  use ExUnit.Case

  alias HackerNewsAggregator.{
    Fetcher,
    PubSub
  }

  describe "handle_continue/2" do
    test "fetch top stories" do
      PubSub.subscribe("top_stories_fetched")
      Fetcher.handle_continue(:fetch, [])
      assert_received(%{topic: "top_stories_fetched"})

      assert_receive(:fetch, 200)

      assert_receive(:fetch, 200)
    end
  end

  describe "handle_info/2" do
    test "fetch top stories" do
      PubSub.subscribe("top_stories_fetched")
      Fetcher.handle_info(:fetch, [])
      assert_received(%{topic: "top_stories_fetched"})
    end
  end
end
