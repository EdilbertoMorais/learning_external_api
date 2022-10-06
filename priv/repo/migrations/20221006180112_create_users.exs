defmodule MyApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :cep, :string
      add :city, :string
      add :uf, :string

      timestamps()
    end
  end
end
