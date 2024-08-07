defmodule BananaBank.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add :name, :string, null: false
      add :password_hash, :string, null: false
      add :email, :string, null: false
      add :cep, :string, null: false

      timestamps()
      # adiciona as colunas inserted_at e updated_at
    end
  end
end
