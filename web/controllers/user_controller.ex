defmodule Projare.UserController do
  use Projare.Web, :controller

  alias Projare.User
  alias Projare.UserService

  def login(conn, %{"email" => email, "password" => password}) do
    user = User.authenticate(Repo.get_by(User, email: email), password)
    render_login(conn, user)
  end
  def login(conn, _params) do
    send_resp(conn, 400, Poison.encode!(%{"error" => "Please provide your email and password"}))
  end

  def facebook_login(conn, %{"userID" => user_id, "token" => token}) do
    user = UserService.facebook_login(user_id, token)
    render_login(conn, user)
  end
  def facebook_login(conn, _params) do
    send_resp(conn, 400, Poison.encode!(%{"error" => "Incorrect facebook login request"}))
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
        |> render(Projare.ChangesetView, "error.json", changeset: changeset)
    end
  end

  defp render_login(conn, %User{} = user) do
    render(conn, "show.json", user: user, full: true)
  end
  defp render_login(conn, _) do
    conn |> put_status(:unauthorized) |> render("login_error.json")
  end
end
