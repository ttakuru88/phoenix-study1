defmodule PhxAppWeb.MessageControllerTest do
  use PhxAppWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "ログ"
  end
end
