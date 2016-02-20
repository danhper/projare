defmodule Projare.PageController do
  use Projare.Web, :controller

  def index(conn, params) do
    render(conn, "index.html", params)
  end
end
