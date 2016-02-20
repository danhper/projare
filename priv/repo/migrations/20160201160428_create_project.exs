defmodule Projare.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :url, :string
      add :title, :string
      add :description, :text
      add :created_at, :datetime
    end
  end
end
