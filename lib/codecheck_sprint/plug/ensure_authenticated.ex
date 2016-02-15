defmodule CodecheckSprint.Plug.EnsureAuthenticated do
  @behaviour Plug

  def init(_opts), do: []

  def call(conn, _opts) do
    if CodecheckSprint.Plug.signed_in?(conn) do
      conn
    else
      CodecheckSprint.Plug.halt_with_error(conn, 401, "not authenticated")
    end
  end
end
