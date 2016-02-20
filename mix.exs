defmodule Projare.Mixfile do
  use Mix.Project

  def project do
    [app: :projare,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  def application do
    [mod: {Projare, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :postgrex, :secure_password, :httpoison]]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  defp deps do
    [{:phoenix,             "~> 1.1.4"},
     {:postgrex,            ">= 0.0.0"},
     {:phoenix_ecto,        "~> 2.0"},
     {:phoenix_html,        "~> 2.4"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext,             "~> 0.9"},
     {:secure_random,       "~> 0.2"},
     {:secure_password,     "~> 0.3.0"},
     {:exgravatar,          "~> 2.0.0"},
     {:httpoison,           "~> 0.8.0"},
     {:cowboy,              "~> 1.0"}]
  end

  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end
end
