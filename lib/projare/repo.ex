defmodule Projare.Repo do
  use Ecto.Repo, otp_app: :projare

  require Ecto.Query

  def paginate(query, params) do
    limit = min(int_value(params, "limit", 20), 50)
    offset = int_value(params, "offset", 0)
    query
    |> Ecto.Query.limit(^limit)
    |> Ecto.Query.offset(^offset)
    |> all
  end

  defp int_value(params, key, default) do
    with {:ok, val} <- Map.fetch(params, key),
         {int, _}   <- Integer.parse(val) do
      {:ok, int}
    end |> case do
      {:ok, int} -> int
      _          -> default
    end
  end
end
