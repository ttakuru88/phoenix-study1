defmodule PhxApp.Repo.Migrations.AddThreadsTable do
  use Ecto.Migration

  def change do
    create table(:threads) do
      add :title, :string
      add :body, :text
      add :user_id, references(:users)
      timestamps()
    end
    create index(:threads, [:user_id])
  end
end
