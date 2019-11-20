defmodule HackerNewsAggregatorWeb.StoryView do
  use HackerNewsAggregatorWeb, :view
  alias HackerNewsAggregatorWeb.StoryView

  def render("index.json", %{stories: stories}) do
    %{data: render_many(stories, StoryView, "story.json")}
  end

  def render("show.json", %{story: story}) do
    %{data: render_one(story, StoryView, "story.json")}
  end

  def render("story.json", %{story: {id, story}}) do
    %{
      id: id,
      title: story["title"],
      by: story["by"],
      descendants: story["descendants"],
      kids: story["kids"],
      score: story["score"],
      time: story["time"],
      type: story["type"],
      url: story["url"]
    }
  end
end
