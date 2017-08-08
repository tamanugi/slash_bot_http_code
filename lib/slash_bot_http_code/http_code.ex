defmodule SlashBotHttpCode.HttpCode do

  use Agent

  @wiki_url "https://ja.wikipedia.org/wiki/HTTP%E3%82%B9%E3%83%86%E3%83%BC%E3%82%BF%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%89"

  def start_link(_init) do
    res = Agent.start_link(fn -> [] end, name: __MODULE__)
    init()
    res
  end

  def get(key) do
    Agent.get(__MODULE__,
      fn http_code_list ->
        http_code_list
        |> Enum.filter(fn item ->
          to_string(item[:status_code]) == key end)
        |> List.first
      end)
  end

  def init() do
    %{body: html} = HTTPoison.get! @wiki_url
    http_code_list = html
    |> Floki.find("dt, dd")
    |> parse

    Agent.update(__MODULE__, fn _ -> http_code_list end)
  end

  def parse(nodes), do: parse(nodes, [], %{})
  def parse([], result, _), do: result
  def parse([head | tail], result, tmp) do
    {tag, _, children_nodes} = head
    text = Floki.text(children_nodes)

    {result, tmp} = case tag do
      "dt" ->
        status_code = text |> String.replace(~r/ .*/, "") |> String.to_integer
        {[tmp | result], %{summary: text, status_code: status_code}}
      "dd" ->
        description =
          case tmp[:description] do
            nil -> text
            desc -> "#{desc}\n#{text}"
          end
       {result, tmp |> Map.put(:description, description)}
    end

    parse(tail, result, tmp)
  end

end
