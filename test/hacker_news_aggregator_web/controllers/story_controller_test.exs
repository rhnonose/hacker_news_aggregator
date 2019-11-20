defmodule HackerNewsAggregatorWeb.StoryControllerTest do
  use HackerNewsAggregatorWeb.ConnCase

  setup %{conn: conn} do
    :ets.new(:top_stories, [:set, :public, :named_table, read_concurrency: true])

    :ets.insert(:top_stories, {1, %{"title" => "some title"}})
    :ets.insert(:top_stories, {2, %{"title" => "some title"}})

    :ets.insert(
      :top_stories,
      {3,
       %{
         "title" => "some title",
         "by" => "jose",
         "descendants" => 45,
         "kids" => [4, 5],
         "score" => 45,
         "time" => 1_574_243_386,
         "type" => "story",
         "url" => "https://example.com/mah_url"
       }}
    )

    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all stories", %{conn: conn} do
      conn = get(conn, Routes.story_path(conn, :index))
      assert [_, _, _] = json_response(conn, 200)["data"]
    end
  end

  describe "show" do
    test "show story", %{conn: conn} do
      conn = get(conn, Routes.story_path(conn, :show, 3))

      assert %{
               "id" => 3,
               "title" => "some title",
               "by" => "jose",
               "descendants" => 45,
               "kids" => [4, 5],
               "score" => 45,
               "time" => 1_574_243_386,
               "type" => "story",
               "url" => "https://example.com/mah_url"
             } == json_response(conn, 200)["data"]
    end
  end
end
