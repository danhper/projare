defmodule CodecheckSprint.PageController do
  use CodecheckSprint.Web, :controller

  def index(conn, params) do
    render(conn, "index.html", params)
  end
end
