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
      [{_id, story}] -> {:ok, story}
    end
  end

  @spec index :: list(term)
  def index(params \\ %{}) do
    @table_name
    |> :ets.tab2list()
    |> Enum.map(fn {_id, body} -> body end)
    |> paginate(params)
  end

  defp paginate(list, params) do
    page_size = params |> Map.get("page_size", "10") |> String.to_integer()
    page_number = params |> Map.get("page_number", "0") |> String.to_integer()

    {_, paginated} = Enum.split(list, page_number)
    Enum.take(paginated, page_size)
  end
end
