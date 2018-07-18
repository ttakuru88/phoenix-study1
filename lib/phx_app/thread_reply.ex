defmodule PhxApp.ThreadReply do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhxApp.{User, Thread}

  schema "thread_replies" do
    field :body, :string
    belongs_to :user, User
    belongs_to :thread, Thread

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body])
    |> validate_required([:body])
  end
end
