defmodule Projare.Plug.FetchResource do
  @behaviour Plug

  import Plug.Conn

  def init(opts) do
    Keyword.put_new(opts, :repo, Projare.Repo)
  end

  def call(%Plug.Conn{params: %{"id" => id}} = conn, opts) do
    case opts[:repo].get(opts[:model], id) do
      nil -> Projare.Plug.halt_with_error(conn, 404, "resource not found")
      resource -> assign(conn, :resource, resource)
    end
  end
end
