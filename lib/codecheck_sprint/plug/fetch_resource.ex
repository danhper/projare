defmodule CodecheckSprint.Plug.FetchResource do
  @behaviour Plug

  import Plug.Conn

  def init(opts) do
    Keyword.put_new(opts, :repo, CodecheckSprint.Repo)
  end

  def call(%Plug.Conn{params: %{"id" => id}} = conn, opts) do
    case opts[:repo].get(opts[:model], id) do
      nil -> CodecheckSprint.Plug.halt_with_error(conn, 404, "resource not found")
      resource -> assign(conn, :resource, resource)
    end
  end
end
