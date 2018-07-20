defmodule PhxApp.TestUser do
  use ExUnit.CaseTemplate

  alias PhxApp.{User, Repo}

  setup %{conn: conn} do
    {:ok, user} = User.changeset_on_create(%User{}, %{name: "testman", password: "passpass"})
      |> Repo.insert

    [conn: conn, user: user]
  end
end
