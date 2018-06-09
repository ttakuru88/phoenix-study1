defmodule PhxApp.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]
  alias PhxApp.{User, Repo}
  require Logger

  schema "users" do
    field :money, :integer
    field :name, :string
    field :password, :string, virtual: true
    field :hashed_password, :string

    timestamps()
  end

  def authenticate(name, password) do
    user = Repo.get_by(User, name: name)
    case checkpw(user, password) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  defp checkpw(nil, password) do
    false
  end

  defp checkpw(user, password) do
    Comeonin.Argon2.checkpw(password, user.hashed_password)
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
