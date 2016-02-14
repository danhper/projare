defmodule CodecheckSprint.Repo.Migrations.CreateCategory do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :normalized_name, :string
      add :icon, :string

      timestamps
    end

    alter table(:projects) do
      add :category_id, references(:categories), null: false
    end

    create index(:projects, [:category_id])
  end
end
