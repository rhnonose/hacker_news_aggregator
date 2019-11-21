# HackerNewsAggregator

## Installation

  * `mix deps.get`
  * `mix compile`

## Test

  * `mix test`

## Run

  * `mix phx.server` or `iex -S mix phx.server`

## Using

To get all top stories, go to `http://localhost:4000/api/stories`
To paginate, `https://localhost:4000/api/stories?page_size=10&page_number=2`
And get a single story: `http://localhost:4000/api/stories/ID`

To use the websocket api:

```bash
  wsta 'ws://localhost:4000/socket/websocket' \
  '{"topic":"top_stories_fetched","event":"phx_join","payload":{},"ref":"1"}'
```
