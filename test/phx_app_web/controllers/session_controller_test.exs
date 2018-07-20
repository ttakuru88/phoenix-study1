defmodule PhxAppWeb.SessionControllerTest do
  use PhxAppWeb.ConnCase
  use PhxApp.TestUser, async: true
  use Plug.Test

  describe "未ログイン" do
    test "GET /sessions/new", %{conn: conn} do
      conn = get(conn, "/sessions/new")
      assert html_response(conn, 200) =~ "login"
    end
  end

  describe "ログイン済み" do
    test "GET /sessions/new", %{conn: conn, user: user} do
      conn = conn
        |> init_test_session(%{user_id: user.id})
        |> get("/sessions/new")
      assert redirected_to(conn) =~ "/"
    end
  end
end
