defmodule Projare.User do
  use Projare.Web, :model
  use SecurePassword

  schema "users" do
    field :name, :string
    field :email, :string
    field :secret_token, :string
    field :facebook_id, :string
    field :image_url, :string

    has_many :projects, Projare.Project, foreign_key: :author_id
    has_many :comments, Projare.Comment, foreign_key: :author_id

    has_secure_password

    timestamps
  end

  @required_fields ~w(name email)
  @optional_fields ~w(password)

  def changeset(model, params \\ :empty) do
    common_changeset(model, params)
    |> with_secure_password(min_length: 6)
  end

  def facebook_changeset(model, params \\ :empty) do
    common_changeset(model, params, [:facebook_id, :image_url])
  end

  defp common_changeset(model, params, extra_fields \\ []) do
    model
    |> cast(params, @required_fields, @optional_fields ++ extra_fields)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/.+@[^\.]+.*/)
    |> validate_length(:name, max: 40)
    |> validate_length(:email, max: 100)
    |> prepare_changes(&generate_secret_token/1)
    |> unique_constraint(:secret_token)
  end

  defp generate_secret_token(changeset) do
    put_change(changeset, :secret_token, SecureRandom.urlsafe_base64(50))
  end
end
