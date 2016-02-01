defmodule CodecheckSprint.ProjectView do
  use CodecheckSprint.Web, :view

  def render("index.json", %{projects: projects}) do
    render_many(projects, CodecheckSprint.ProjectView, "project.json")
  end

  def render("show.json", %{project: project}) do
    render_one(project, CodecheckSprint.ProjectView, "project.json")
  end

  def render("project.json", %{project: project}) do
    %{id: project.id,
      url: project.url,
      title: project.title,
      description: project.description,
      created_at: project.created_at}
  end
end
