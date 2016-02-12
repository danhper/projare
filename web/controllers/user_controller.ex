defmodule CodecheckSprint.UserController do
  use CodecheckSprint.Web, :controller

  alias CodecheckSprint.User

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.json", users: users)
  end

  def create(conn, user_params) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_path(conn, :show, user))
        |> render("show.json", user: user, full: true)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CodecheckSprint.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id} = user_params) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CodecheckSprint.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
