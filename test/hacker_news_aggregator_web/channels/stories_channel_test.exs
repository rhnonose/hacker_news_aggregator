defmodule HackerNewsAggregatorWeb.StoriesChannelTest do
  use HackerNewsAggregatorWeb.ChannelCase

  setup do
    :ets.new(:top_stories, [:set, :public, :named_table, read_concurrency: true])

    :ets.insert(:top_stories, {1, %{"title" => "some title"}})
    :ets.insert(:top_stories, {2, %{"title" => "some title"}})
    :ets.insert(:top_stories, {3, %{"title" => "some title"}})

    :ok
  end

  test "receives stories upon connection" do
    HackerNewsAggregatorWeb.UserSocket
    |> socket("user_id", %{some: :assign})
    |> subscribe_and_join(HackerNewsAggregatorWeb.StoriesChannel, "top_stories_fetched")

    assert_push "top_stories_fetched", %{
      data: [
        %{"title" => "some title"},
        %{"title" => "some title"},
        %{"title" => "some title"}
      ]
    }
  end

  test "top_stories_fetched publishes are pushed to the client" do
    HackerNewsAggregatorWeb.UserSocket
    |> socket("user_id", %{some: :assign})
    |> subscribe_and_join(HackerNewsAggregatorWeb.StoriesChannel, "top_stories_fetched")

    assert_push "top_stories_fetched", _

    [
      %{"title" => "some title"},
      %{"title" => "some title"},
      %{"title" => "some title"}
    ]
    |> HackerNewsAggregator.PubSub.publish("top_stories_fetched")

    assert_push "top_stories_fetched", %{
      data: [
        %{"title" => "some title"},
        %{"title" => "some title"},
        %{"title" => "some title"}
      ]
    }
  end
end
