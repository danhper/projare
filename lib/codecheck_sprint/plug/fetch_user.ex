defmodule CodecheckSprint.Plug.FetchUser do
  @behaviour Plug

  import Plug.Conn

  alias CodecheckSprint.Repo
  alias CodecheckSprint.User

  def init(_opts) do
    []
  end

  def call(conn, _params) do
    case fetch_user(get_req_header(conn, "authorization")) do
      %User{} = user -> assign(conn, :current_user, user)
      _              -> conn
    end
  end

  defp fetch_user(["Bearer " <> token]) do
    Repo.get_by(User, secret_token: token)
  end
  defp fetch_user(_), do: nil
end
