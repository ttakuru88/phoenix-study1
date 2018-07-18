defmodule PhxApp.Thread do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhxApp.{User, ThreadReply}

  schema "threads" do
    field :title, :string
    field :body, :string
    belongs_to :user, User
    has_many :replies, {"thread_replies", ThreadReply}
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body, :user_id])
    |> validate_required([:title, :body, :user_id])
  end
end
