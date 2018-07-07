defmodule PhxApp.Thread do
  use PhxApp.Web, :model

  schema "threads" do
    field :title, :string
    field :body, :text
    belongs_to :user, User
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
