defmodule CodecheckSprint.Plug do
  import Plug.Conn

  def signed_in?(conn) do
    not is_nil(current_user(conn))
  end

  def current_user(conn) do
    conn.assigns[:current_user]
  end

  def resource(conn) do
    conn.assigns[:resource]
  end

  def send_json(conn, status, params) do
    conn
    |> put_resp_header("Content-Type", "application/json")
    |> send_resp(status, Poison.encode!(params))
  end

  def halt_with_error(conn, status, error) do
    send_json(conn, status, %{error: error}) |> halt
  end
end
