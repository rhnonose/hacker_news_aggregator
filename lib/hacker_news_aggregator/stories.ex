defmodule HackerNewsAggregator.Stories do
  @table_name :top_stories

  @type do_get :: {:ok, term} | {:error, :not_found}

  @spec get(String.t() | number) :: do_get
  def get(id) when is_binary(id) do
    id
    |> String.to_integer()
    |> do_get()
  end

  def get(id), do: do_get(id)

  @spec do_get(number) :: do_get
  defp do_get(id) do
    case :ets.lookup(@table_name, id) do
      [] -> {:error, :not_found}
      [story] -> {:ok, story}
    end
  end

  @spec index :: list(term)
  def index, do: :ets.tab2list(:top_stories)
end
