defmodule Projare.ProjectView do
  use Projare.Web, :view

  def render("index.json", %{projects: projects}) do
    render_many(projects, Projare.ProjectView, "project.json")
  end

  def render("show.json", %{project: project}) do
    render_one(project, Projare.ProjectView, "project.json")
  end

  def render("project.json", %{project: project}) do
    %{id: project.id,
      url: project.url,
      title: project.title,
      stars_count: project.stars_count,
      comments_count: project.comments_count,
      starred: project.starred,
      commented: project.commented,
      description: project.description,
      created_at: project.created_at,
      author: render_one(project.author, Projare.UserView, "user.json"),
      category: render_one(project.category, Projare.CategoryView, "category.json")}
  end
end
