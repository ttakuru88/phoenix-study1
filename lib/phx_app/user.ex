defmodule PhxApp.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :money, :integer
    field :name, :string
    field :password, :string, virtual: true
    field :hashed_password, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :money, :password])
    |> validate_required([:name, :money, :password])
    |> hash_password()
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        changeset
          |> put_change(:hashed_password, Comeonin.Argon2.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
