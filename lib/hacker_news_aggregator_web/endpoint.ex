defmodule HackerNewsAggregatorWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :hacker_news_aggregator

  socket "/socket", HackerNewsAggregatorWeb.UserSocket,
    websocket: true,
    longpoll: false

  plug Plug.Static,
    at: "/",
    from: :hacker_news_aggregator,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_hacker_news_aggregator_key",
    signing_salt: "3Cn1SLJ3"

  plug HackerNewsAggregatorWeb.Router
end
