defmodule CodecheckSprint.CategoryController do
  use CodecheckSprint.Web, :controller

  alias CodecheckSprint.Category

  def index(conn, _params) do
    categories = Repo.all(Category)
    render(conn, "index.json", categories: categories)
  end
end
