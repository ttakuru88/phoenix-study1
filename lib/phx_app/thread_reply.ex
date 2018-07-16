defmodule PhxApp.ThreadReply do
  use PhxApp.Web, :model

  schema "thread_replies" do
    field :body, :string
    belongs_to :user, PhxApp.User, foreign_key: :user_id
    belongs_to :thread, PhxApp.Thread, foreign_key: :thread_id

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
