defmodule Projare.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text, null: false

      add :project_id, references(:projects), null: false
      add :author_id, references(:users), null: false

      timestamps
    end

    alter table(:projects) do
      add :comments_count, :integer, null: false, default: 0
    end

    create index(:comments, [:author_id])
    create index(:comments, [:project_id])
  end
end
