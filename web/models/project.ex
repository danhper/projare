defmodule CodecheckSprint.Project do
  use CodecheckSprint.Web, :model

  schema "projects" do
    field :url, :string
    field :title, :string
    field :description, :string

    belongs_to :author, CodecheckSprint.User

    timestamps inserted_at: :created_at, updated_at: false
  end

  @required_fields ~w(url title description)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def for_author(query, id) when is_binary(id) or is_integer(id) do
    from p in query, where: p.author_id == ^id
  end
  def for_author(query, _), do: query

  def preload_author(query) do
    from p in query, preload: [:author]
  end

  def with_word(query, nil), do: query
  def with_word(query, word) do
    from p in query,
      where: ilike(p.title, ^("%#{word}%")) or ilike(p.description, ^("%#{word}%"))
  end

  def order(query, reversed) when reversed == true or reversed == "true",
    do: from p in query, order_by: [desc: p.created_at]
  def order(query, _), do: query
end
