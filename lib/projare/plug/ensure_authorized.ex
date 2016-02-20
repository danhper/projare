defmodule Projare.Plug.EnsureAuthorized do
  @behaviour Plug

  alias Projare.Plug.EnsureAuthorized

  def init(opts) do
    opts
    |> Keyword.put_new(:authorized_fn, &EnsureAuthorized.authorized?/2)
    |> Keyword.put_new(:user_key, :user)
  end

  def call(conn, opts) do
    if opts[:authorized_fn].(conn, opts) do
      conn
    else
      Projare.Plug.halt_with_error(conn, 403, "not authorized")
    end
  end

  def authorized?(conn, opts) do
    resource = Projare.Plug.resource(conn)
    user = Projare.Plug.current_user(conn)
    Map.fetch!(resource, opts[:user_key]) == user.id
  end
end
