defmodule CodecheckSprint.Comment do
  use CodecheckSprint.Web, :model

  schema "comments" do
    field :body, :string

    belongs_to :author, CodecheckSprint.User
    belongs_to :project, CodecheckSprint.Project

    timestamps
  end

  @required_fields ~w(body project_id)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:body, min: 3)
  end

  def with_author(query) do
    from c in query, preload: [:author]
  end

  def for_project(query, id) when is_binary(id) or is_integer(id) do
    from c in query, where: c.project_id == ^id
  end
  def for_project(query, _), do: query

  def for_user(query, user) do
    from c in query, where: c.author_id == ^user.id
  end

  def for_projects(query, projects) do
    project_ids = Enum.map(projects, &(&1.id))
    from c in query, where: c.project_id in ^project_ids
  end
end
