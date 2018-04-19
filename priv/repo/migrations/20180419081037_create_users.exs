defmodule PhxApp.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :money, :integer

      timestamps()
    end

  end
end
