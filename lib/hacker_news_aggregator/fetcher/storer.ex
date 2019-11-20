defmodule HackerNewsAggregator.Storer do
  @moduledoc """
  GenServer responsible for storing top stories published on PubSub
  """
  use GenServer

  alias HackerNewsAggregator.PubSub

  @table_name :top_stories
  @table_opts [:set, :public, :named_table, read_concurrency: true]

  @spec start_link :: GenServer.start_link()
  def start_link, do: GenServer.start_link(__MODULE__, [], name: __MODULE__)

  @spec init(term) :: {:ok, term}
  def init(_) do
    PubSub.subscribe("top_stories_fetched")

    # TODO: create ets table with application as owner to prevent being dropped when this genserver crashes
    create_ets_table()

    {:ok, []}
  end

  def handle_info(%{topic: "top_stories_fetched", payload: payload}, state) do
    clean_ets_table()

    payload
    |> Enum.map(&Jason.decode!/1)
    |> Enum.each(fn %{"id" => id} = body -> :ets.insert(@table_name, {id, body}) end)

    {:noreply, state}
  end

  defp create_ets_table do
    case :ets.whereis(@table_name) do
      :undefined -> :ets.new(@table_name, @table_opts)
      _ -> :ok
    end
  end

  defp clean_ets_table, do: :ets.delete_all_objects(@table_name)
end
