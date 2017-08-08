defmodule SlashBotHttpCode.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, SlashBotHttpCode.Router, [], [port: 4000]),
      {SlashBotHttpCode.HttpCode, []}
    ]

    opts = [strategy: :one_for_one, name: SlashBotHttpCode.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
