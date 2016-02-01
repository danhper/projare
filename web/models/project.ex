defmodule CodecheckSprint.Project do
  use CodecheckSprint.Web, :model

  schema "projects" do
    field :url, :string
    field :title, :string
    field :description, :string

    timestamps inserted_at: :created_at, updated_at: false
  end

  @required_fields ~w(url title description)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
