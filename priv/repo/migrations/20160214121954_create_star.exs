defmodule CodecheckSprint.Repo.Migrations.CreateStar do
  use Ecto.Migration

  def change do
    create table(:stars) do
      add :user_id, references(:users), null: false
      add :project_id, references(:projects), null: false

      timestamps
    end

    alter table(:projects) do
      add :stars_count, :integer, null: false, default: 0
    end

    create index(:stars, [:user_id])
    create unique_index(:stars, [:user_id, :project_id])
  end
end
