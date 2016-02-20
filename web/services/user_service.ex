defmodule Projare.UserService do
  use Projare.Web, :service

  alias Projare.User

  def facebook_login(facebook_id, token) do
    case Projare.Facebook.me(token) do
      {:ok, %HTTPoison.Response{status_code: 200, body: %{facebook_id: ^facebook_id} = facebook_info}} ->
        facebook_info |> Map.delete(:token) |> with_picture |> create_or_login_user
      {:ok, %HTTPoison.Response{status_code: 200}} -> {:error, 401, "Bad user id"}
      {:ok, %HTTPoison.Response{} = res} -> {:error, res.status_code, "Facebook login failed"}
      _ -> {:error, 500, "Could not contact Facebook"}
    end
  end

  defp create_or_login_user(facebook_info) do
    if user = Repo.get_by(User, facebook_id: facebook_info.facebook_id) do
      Repo.update! make_changeset(user, facebook_info)
    else
      make_changeset(%User{}, facebook_info) |> Repo.insert!
    end
  end

  defp make_changeset(user, facebook_info) do
    fields = facebook_info |> Map.keys |> Enum.filter(&(is_nil Map.fetch!(user, &1)))
    User.facebook_changeset(user, Map.take(facebook_info, fields))
  end

  defp with_picture(info) do
    Map.put(info, :image_url, "https://graph.facebook.com/#{info.facebook_id}/picture?type=large")
  end
end
