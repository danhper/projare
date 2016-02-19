defmodule CodecheckSprint.Facebook do
  use HTTPoison.Base

  @default_fields ~w(name email)
  @expected_fields ~w(id error)

  def me(token, fields \\ @default_fields) do
    get("/me", [Authorization: "Bearer #{token}"], params: [fields: make_fields(fields)])
    |> process_me(fields)
  end

  defp process_me({:ok, res}, fields) do
    expected_fields = @expected_fields ++ split_fields(fields)
    body = Poison.decode!(res.body)
    |> Map.take(expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
    |> Enum.into(%{})
    |> map_id
    {:ok, %{res | body: body}}
  end
  defp process_me({:error, _} = error, _), do: error

  defp map_id(%{id: id} = map), do: map |> Map.put(:facebook_id, id) |> Map.delete(:id)
  defp map_id(map), do: map

  def process_url(url) do
    "https://graph.facebook.com" <> url
  end

  defp make_fields(fields) when is_list(fields), do: Enum.join(fields, ",")
  defp make_fields(fields) when is_binary(fields), do: fields

  defp split_fields(fields) when is_binary(fields) do
    String.split(fields, ",") |> Enum.map(&(String.strip(&1)))
  end
  defp split_fields(fields) when is_list(fields), do: fields
end
