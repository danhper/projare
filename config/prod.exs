use Mix.Config

config :projare, Projare.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "projare.herokuapp.com", port: 443],
  cache_static_manifest: "priv/static/manifest.json"

config :logger, level: :info

config :projare, Projare.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: 20

config :projare, :facebook,
  api_key: "1524716531165969"
