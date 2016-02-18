defmodule CodecheckSprint.CommentController do
  use CodecheckSprint.Web, :controller

  @resource_actions ~w(update delete)a

  alias CodecheckSprint.Comment
  alias CodecheckSprint.Project
  alias CodecheckSprint.CommentService

  plug EnsureAuthenticated when action in ~w(create update delete)a
  plug FetchResource, [model: Comment] when action in @resource_actions
  plug EnsureAuthorized, [user_key: :author_id] when action in ~w(update delete)a

  def index(conn, %{"project_id" => project_id} = params) do
    comments = Comment
              |> Comment.for_project(project_id)
              |> Comment.with_author
              |> Repo.paginate(params)
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"project_id" => project_id} = comment_params) do
    project = Repo.get!(Project, project_id)
    current_user(conn)
    |> Ecto.build_assoc(:comments)
    |> Comment.changeset(comment_params)
    |> CommentService.create_comment(project)
    |> handle_save(conn)
  end

  def update(conn, comment_params) do
    resource(conn)
    |> Comment.changeset(comment_params)
    |> Repo.update
    |> handle_save(conn)
  end

  def delete(conn, %{"project_id" => project_id}) do
    project = Repo.get!(Project, project_id)
    resource(conn) |> CommentService.delete_comment!(project)
    send_resp(conn, :no_content, "")
  end

  defp handle_save({:ok, comment}, conn) do
    render(conn, "show.json", comment: Repo.preload(comment, [:author]))
  end
  defp handle_save({:error, changeset}, conn) do
    conn
    |> put_status(:bad_request)
    |> render(CodecheckSprint.ChangesetView, "error.json", changeset: changeset)
  end
end
