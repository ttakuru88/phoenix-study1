defmodule PhxApp.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhxApp.{User}

  schema "users" do
    field :money, :integer
    field :name, :string
    field :password, :string, virtual: true
    field :hashed_password, :string
    has_many :threads, Thread

    timestamps()
  end

  @doc false
  def changeset_on_create(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :money, :password])
    |> validate_required([:name, :password])
    |> hash_password()
  end

  def changeset_on_edit(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :money])
    |> validate_required([:name])
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
