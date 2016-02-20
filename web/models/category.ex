defmodule Projare.Category do
  use Projare.Web, :model

  schema "categories" do
    field :name, :string
    field :normalized_name, :string
    field :icon, :string

    timestamps
  end

  @required_fields ~w(name normalized_name icon)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
