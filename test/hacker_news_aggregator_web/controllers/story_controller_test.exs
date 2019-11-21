defmodule HackerNewsAggregatorWeb.StoryControllerTest do
  use HackerNewsAggregatorWeb.ConnCase

  setup %{conn: conn} do
    :ets.new(:top_stories, [:ordered_set, :public, :named_table, read_concurrency: true])

    :ets.insert(:top_stories, {1, %{"id" => 1, "title" => "some title"}})
    :ets.insert(:top_stories, {2, %{"id" => 2, "title" => "some title"}})
    :ets.insert(:top_stories, {3, %{"id" => 3, "title" => "some title"}})
    :ets.insert(:top_stories, {4, %{"id" => 4, "title" => "some title"}})
    :ets.insert(:top_stories, {5, %{"id" => 5, "title" => "some title"}})

    :ets.insert(
      :top_stories,
      {6,
       %{
         "id" => 6,
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
      assert [_, _, _, _, _, _] = json_response(conn, 200)["data"]
    end

    test "lists stories paginated", %{conn: conn} do
      conn = get(conn, Routes.story_path(conn, :index, %{"page_size" => 2, "page_number" => 2}))
      assert [%{"id" => 3}, %{"id" => 4}] = json_response(conn, 200)["data"]
    end
  end

  describe "show" do
    test "show story", %{conn: conn} do
      conn = get(conn, Routes.story_path(conn, :show, 6))

      assert %{
               "id" => 6,
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

    test "render 404 when not found", %{conn: conn} do
      conn = get(conn, Routes.story_path(conn, :show, 10))

      assert json_response(conn, 404)
    end
  end
end
