defmodule WoWData.Repo.Migrations.AddAccessTokenTable do
  use Ecto.Migration

  def change do
    create table(:access_tokens) do
      add :value, :string

      timestamps()
    end
  end
end
