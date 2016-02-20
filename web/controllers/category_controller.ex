defmodule Projare.CategoryController do
  use Projare.Web, :controller

  alias Projare.Category

  def index(conn, _params) do
    categories = Repo.all(Category)
    render(conn, "index.json", categories: categories)
  end
end
