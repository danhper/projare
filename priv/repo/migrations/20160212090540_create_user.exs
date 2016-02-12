defmodule CodecheckSprint.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :password_digest, :string

      add :secret_token, :string

      timestamps
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:secret_token])
  end
end
