defmodule Projare.Endpoint do
  use Phoenix.Endpoint, otp_app: :projare

  plug Plug.Static,
    at: "/", from: :projare, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt components)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_projare_sprint_key",
    signing_salt: "3f73Owud"

  plug Projare.Router
end
