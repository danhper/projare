defmodule CodecheckSprint.Project do
  use CodecheckSprint.Web, :model

  @url_regex ~r"^(https?://)?([\da-z\.-]+)\.([a-z\.]{2,6})([/\w \.-]*)*/?$"

  schema "projects" do
    field :url, :string
    field :title, :string
    field :description, :string
    field :stars_count, :integer, default: 0
    field :comments_count, :integer, default: 0

    field :starred, :boolean, virtual: true, default: false
    field :commented, :boolean, virtual: true, default: false

    belongs_to :author, CodecheckSprint.User
    belongs_to :category, CodecheckSprint.Category

    timestamps inserted_at: :created_at, updated_at: false
  end

  @required_fields ~w(url title description category_id)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:url, @url_regex)
    |> validate_length(:title, max: 100)
    |> validate_length(:description, min: 10)
    |> assoc_constraint(:category)
  end

  def star_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(stars_count), [])
    |> validate_number(:stars_count, greater_than_or_equal_to: 0)
  end

  def comment_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(comments_count), [])
    |> validate_number(:comments_count, greater_than_or_equal_to: 0)
  end

  def for_params(query, params) when is_map(params) do
    query
    |> with_word(params["q"])
    |> reverse_order(params["reversed"])
    |> ranking_order(params["ranking"])
    |> for_author(params["author_id"])
    |> for_category(params["category_name"])
    |> with_preloads
  end

  def for_category(query, name) when is_binary(name) do
    from p in query,
      join: c in assoc(p, :category),
      where: c.normalized_name == ^name
  end
  def for_category(query, _), do: query

  def for_author(query, id) when is_binary(id) or is_integer(id) do
    from p in query, where: p.author_id == ^id
  end
  def for_author(query, _), do: query

  def with_preloads(query) do
    from p in query, preload: [:author, :category]
  end

  def with_word(query, nil), do: query
  def with_word(query, word) do
    from p in query,
      where: ilike(p.title, ^("%#{word}%")) or ilike(p.description, ^("%#{word}%"))
  end

  def ranking_order(query, ranking) when ranking == true or ranking == "true",
    do: from p in query, order_by: [desc: p.stars_count, desc: p.comments_count]
  def ranking_order(query, _), do: query

  def reverse_order(query, reversed) when reversed == true or reversed == "true",
    do: from p in query, order_by: [desc: p.created_at]
  def reverse_order(query, _), do: query
end
