defmodule Projare.Repo.Migrations.AddUserToProjects do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add :author_id, :integer, null: false
    end

    create index(:projects, [:author_id])
  end
end
