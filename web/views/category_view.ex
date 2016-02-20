defmodule Projare.CategoryView do
  use Projare.Web, :view

  def render("index.json", %{categories: categories}) do
    render_many(categories, Projare.CategoryView, "category.json")
  end

  def render("category.json", %{category: category}) do
    %{id: category.id,
      name: category.name,
      normalized_name: category.normalized_name,
      icon: category.icon}
  end
end
