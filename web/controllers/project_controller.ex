defmodule CodecheckSprint.ProjectController do
  use CodecheckSprint.Web, :controller

  alias CodecheckSprint.Project
  alias CodecheckSprint.ProjectService

  @resource_actions ~w(show update star unstar delete)a

  plug EnsureAuthenticated when action in ~w(create update star unstar delete)a
  plug FetchResource, [model: Project] when action in @resource_actions
  plug EnsureAuthorized, [user_key: :author_id] when action in ~w(update delete)a

  def index(conn, params) do
    projects = Project
              |> Project.for_params(params)
              |> Repo.paginate(params)
              |> ProjectService.assign_starred(current_user(conn))
              |> ProjectService.assign_commented(current_user(conn))
    render(conn, "index.json", projects: projects)
  end

  def create(conn, project_params) do
    current_user(conn)
    |> Ecto.build_assoc(:projects)
    |> Project.changeset(project_params)
    |> Repo.insert
    |> handle_save(conn)
  end

  def show(conn, _params) do
    project = resource(conn) |> Repo.preload([:author, :category])
    render(conn, "show.json", project: load_project(conn, project))
  end

  def update(conn, project_params) do
    resource(conn)
    |> Project.changeset(project_params)
    |> Repo.update
    |> handle_save(conn)
  end

  def star(conn, _params) do
    case ProjectService.star_project(resource(conn), current_user(conn)) do
      :ok -> send_resp(conn, :no_content, "")
      {:error, status, message} -> send_error(conn, status, message)
    end
  end

  def unstar(conn, _params) do
    case ProjectService.unstar_project(resource(conn), current_user(conn)) do
      :ok -> send_resp(conn, :no_content, "")
      {:error, status, message} -> send_error(conn, status, message)
    end
  end

  def delete(conn, _params) do
    resource(conn) |> Repo.delete!
    send_resp(conn, :no_content, "")
  end

  defp handle_save({:ok, project}, conn) do
    render(conn, "show.json", project: load_project(conn, project))
  end
  defp handle_save({:error, changeset}, conn) do
    conn
    |> put_status(:bad_request)
    |> render(CodecheckSprint.ChangesetView, "error.json", changeset: changeset)
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
