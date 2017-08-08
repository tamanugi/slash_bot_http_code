defmodule SlashBotHttpCode.Mixfile do
  use Mix.Project

  def project do
    [
      app: :slash_bot_http_code,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {SlashBotHttpCode.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.4.3"},
      {:cowboy, "~> 1.1.2"},
      {:poison, "~> 3.1.0"},
      {:httpoison, "~> 0.13.0"},
      {:floki, "~> 0.18.0"}
    ]
  end
end
