defmodule HackerNewsAggregator.HttpMock do
  def get(%URI{path: "/v0/topstories"}),
    do: {:ok, %{status_code: 200, body: "[1,2,3]"}}

  def get(%URI{path: "/v0/item/" <> id}) do
    {id_int, ""} = Integer.parse(id)

    {:ok,
     %{
       status_code: 200,
       body: %{
         "by" => "tel",
         "descendants" => 0,
         "id" => id_int,
         "kids" => [],
         "score" => 25,
         "text" => "some text",
         "time" => 1_203_647_620,
         "title" => "some title",
         "type" => "story"
       }
     }}
  end
end
