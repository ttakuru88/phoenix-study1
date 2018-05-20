defmodule PhxApp.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :money, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :money])
    |> validate_required([:name, :money])
  end
end
