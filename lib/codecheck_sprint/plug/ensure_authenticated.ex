defmodule CodecheckSprint.Plug.EnsureAuthenticated do
  @behaviour Plug

  import Plug.Conn

  def init(_opts) do
    []
  end

  def call(conn, _params) do
    if CodecheckSprint.Plug.signed_in?(conn) do
      conn
    else
      conn
      |> put_resp_header("Content-Type", "application/json")
      |> send_resp(401, Poison.encode!(%{"error" => "not authenticated"}))
      |> halt
    end
  end
end
