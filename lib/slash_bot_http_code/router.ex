defmodule SlashBotHttpCode.Router do

  alias SlashBotHttpCode.HttpCode

  use Plug.Router
  plug Plug.Parsers, parsers: [:urlencoded]
  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "")
  end

  post "/" do
    %{"text" => text} = conn.params

    resp = text |> HttpCode.get |> process_resp |> Poison.encode!

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, resp)
  end

  match _ do
    send_resp(conn, 404, "not found")
  end

  def process_resp(%{summary: summary, description: description}) do
    %{
      response_type: "in_channel",
      text: summary,
      attachments: [
        %{
          text: description
        }
      ]
    }
  end

  def process_resp(_) do
    %{text: "Not Found."}
  end
end
