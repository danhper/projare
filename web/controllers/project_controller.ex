defmodule CodecheckSprint.ProjectController do
  use CodecheckSprint.Web, :controller

  plug CodecheckSprint.Plug.EnsureAuthenticated when action in ~w(create star unstar delete)a

  alias CodecheckSprint.Project
  alias CodecheckSprint.ProjectService

  def index(conn, params) do
    projects = Project
              |> Project.with_word(params["q"])
              |> Project.order(params["reversed"])
              |> Project.for_author(params["author_id"])
              |> Project.for_category(params["category_name"])
              |> Project.with_preloads
              |> Repo.paginate(params)
              |> ProjectService.assign_starred(current_user(conn))
    render(conn, "index.json", projects: projects)
  end

  def create(conn, project_params) do
    project = Ecto.build_assoc(current_user(conn), :projects)
    changeset = Project.changeset(project, project_params)

    case Repo.insert(changeset) do
      {:ok, project} ->
        conn |> render("show.json", project: load_project(conn, project))
      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> render(CodecheckSprint.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    project = Repo.get!(Project, id) |> Repo.preload([:author, :category])
    render(conn, "show.json", project: load_project(conn, project))
  end

  def star(conn, %{"id" => id}) do
    case ProjectService.star_project(Repo.get!(Project, id), current_user(conn)) do
      :ok -> send_resp(conn, :no_content, "")
      {:error, status, message} -> send_error(conn, status, message)
    end
  end

  def unstar(conn, %{"id" => id}) do
    case ProjectService.unstar_project(Repo.get!(Project, id), current_user(conn)) do
      :ok -> send_resp(conn, :no_content, "")
      {:error, status, message} -> send_error(conn, status, message)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Repo.get!(Project, id)
    Repo.delete!(project)
    send_resp(conn, :no_content, "")
  end

  defp send_error(conn, status, message) do
    conn
    |> put_status(status)
    |> render(CodecheckSprint.ErrorView, "error.json", error: message)
  end

  defp load_project(conn, project) do
    project
    |> Repo.preload([:author, :category])
    |> ProjectService.assign_starred(current_user(conn))
  end
end
