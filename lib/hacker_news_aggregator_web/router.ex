defmodule HackerNewsAggregatorWeb.Router do
  use HackerNewsAggregatorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HackerNewsAggregatorWeb do
    pipe_through :api

    resources "/stories", StoryController, only: [:index, :show]
  end
end
