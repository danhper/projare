defmodule CodecheckSprint.Repo.Migrations.AddFacebookInfoToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :facebook_id, :string
      add :image_url, :string
    end
  end
end
