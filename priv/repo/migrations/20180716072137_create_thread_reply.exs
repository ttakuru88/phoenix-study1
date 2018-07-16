  defmodule PhxApp.Repo.Migrations.CreateThreadReply do
  use Ecto.Migration

  def change do
    create table(:thread_replies) do
      add :body, :text
      add :user_id, references(:users, on_delete: :nilify_all)
      add :thread_id, references(:threads, on_delete: :delete_all)

      timestamps()
    end

    create index(:thread_replies, [:user_id])
    create index(:thread_replies, [:thread_id])
  end
end
