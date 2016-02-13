defmodule CodecheckSprint.ProjectController do
  use CodecheckSprint.Web, :controller

  alias CodecheckSprint.Project

  def index(conn, params) do
    projects = Project |> Repo.paginate(params)
    render(conn, "index.json", projects: projects)
  end

  def create(conn, project_params) do
    changeset = Project.changeset(%Project{}, project_params)

    case Repo.insert(changeset) do
      {:ok, project} ->
        conn |> render("show.json", project: project)
      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(CodecheckSprint.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    project = Repo.get!(Project, id)
    render(conn, "show.json", project: project)
  end

  def delete(conn, %{"id" => id}) do
    project = Repo.get!(Project, id)
    Repo.delete!(project)
    send_resp(conn, :no_content, "")
  end
end
