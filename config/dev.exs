use Mix.Config

config :projare, Projare.Endpoint,
  http: [port: 3000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    {Path.expand("node_modules/webpack/bin/webpack.js"), ["--watch", "--colors", "--progress"]}
  ]

config :projare, Projare.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :projare, Projare.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "projare_dev",
  hostname: "localhost",
  pool_size: 10
