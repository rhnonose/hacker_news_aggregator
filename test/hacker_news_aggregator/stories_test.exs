defmodule HackerNewsAggregator.StoriesTest do
  use ExUnit.Case

  alias HackerNewsAggregator.Stories

  setup do
    :ets.new(:top_stories, [:set, :public, :named_table, read_concurrency: true])

    :ets.insert(:top_stories, {1, %{}})
    :ets.insert(:top_stories, {2, %{}})
    :ets.insert(:top_stories, {3, %{}})

    :ok
  end

  describe "stories" do
    test "index/0 returns all stories" do
      assert [%{}, %{}, %{}] = Stories.index()
    end

    test "get/1 returns the story with given id" do
      assert {:ok, %{}} = Stories.get(1)
    end
  end
end
