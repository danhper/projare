use Mix.Config

config :codecheck_sprint, CodecheckSprint.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "givery-codecheck.herokuapp.com", port: 443],
  cache_static_manifest: "priv/static/manifest.json"

config :logger, level: :info

config :codecheck_sprint, CodecheckSprint.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: 20

config :codecheck_sprint, :facebook,
  api_key: "1524716531165969"
