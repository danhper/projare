use Mix.Config

config :codecheck_sprint, CodecheckSprint.Endpoint,
  http: [port: 3000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    {Path.expand("node_modules/webpack/bin/webpack.js"), ["--watch", "--colors", "--progress"]}
  ]

config :codecheck_sprint, CodecheckSprint.Endpoint,
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

config :codecheck_sprint, CodecheckSprint.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "codecheck_sprint_dev",
  hostname: "localhost",
  pool_size: 10
