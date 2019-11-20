defmodule HackerNewsAggregatorWeb.StoryController do
  use HackerNewsAggregatorWeb, :controller

  alias HackerNewsAggregator.Stories

  action_fallback HackerNewsAggregatorWeb.FallbackController

  def index(conn, _params) do
    stories = Stories.index()
    render(conn, "index.json", stories: stories)
  end

  def show(conn, %{"id" => id}) do
    with {:ok, story} <- Stories.get(id) do
      render(conn, "show.json", story: story)
    end
  end
end
