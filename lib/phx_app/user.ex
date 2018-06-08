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
    query = from u in User,
      where: u.name == ^name,
      select: struct(u, [:id, :hashed_password])
    user = Repo.one(query)
    if user && Comeonin.Argon2.checkpw(password, user.hashed_password) do
      user
    else
      nil
    end
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
