defmodule PhxAppWeb.SessionControllerTest do
  use PhxAppWeb.ConnCase
  # use ExUnit.Case, async: true
  use Plug.Test

  alias PhxApp.{User, Repo}

  describe "未ログイン" do
    test "GET /sessions/new", %{conn: conn} do
      conn = get(conn, "/sessions/new")
      assert html_response(conn, 200) =~ "login"
    end
  end

  describe "ログイン済み" do
    test "GET /sessions/new", %{conn: conn} do
      {:ok, user} = User.changeset_on_create(%User{}, %{name: "testman", password: "passpass"})
        |> Repo.insert

      conn = conn
        |> init_test_session(%{user_id: user.id})
        |> get("/sessions/new")

      assert redirected_to(conn) =~ "/"
    end
  end
end
