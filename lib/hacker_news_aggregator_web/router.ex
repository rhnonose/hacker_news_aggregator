defmodule HackerNewsAggregatorWeb.Router do
  use HackerNewsAggregatorWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HackerNewsAggregatorWeb do
    pipe_through :api
  end
end
