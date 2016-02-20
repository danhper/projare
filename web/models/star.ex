defmodule Projare.Star do
  use Projare.Web, :model

  schema "stars" do
    belongs_to :user, Projare.User
    belongs_to :project, Projare.Project

    timestamps
  end

  @required_fields ~w()
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def for_user(query, user) do
    from s in query, where: s.user_id == ^user.id
  end

  def for_projects(query, projects) do
    project_ids = Enum.map(projects, &(&1.id))
    from s in query, where: s.project_id in ^project_ids
  end
end
