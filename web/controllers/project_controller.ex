defmodule CodecheckSprint.ProjectController do
  use CodecheckSprint.Web, :controller

  plug CodecheckSprint.Plug.EnsureAuthenticated when action in [:create, :delete]

  alias CodecheckSprint.Project

  def index(conn, params) do
    projects = Project
              |> Project.with_word(params["q"])
              |> Project.order(params["reversed"])
              |> Project.for_author(params["author_id"])
              |> Project.preload_author
              |> Repo.paginate(params)
    render(conn, "index.json", projects: projects)
  end

  def create(conn, project_params) do
    project = Ecto.build_assoc(current_user(conn), :projects)
    changeset = Project.changeset(project, project_params)

    case Repo.insert(changeset) do
      {:ok, project} ->
        conn |> render("show.json", project: Repo.preload(project, :author))
      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(CodecheckSprint.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    project = Repo.get!(Project, id) |> Repo.preload(:author)
    render(conn, "show.json", project: project)
  end

  def delete(conn, %{"id" => id}) do
    project = Repo.get!(Project, id)
    Repo.delete!(project)
    send_resp(conn, :no_content, "")
  end
end
