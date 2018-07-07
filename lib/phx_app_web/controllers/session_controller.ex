defmodule PhxAppWeb.SessionController do
  use PhxAppWeb, :controller
  require Logger
  alias PhxApp.{Authentication}

  def new(conn, _params) do
    if Authentication.signed_in?(conn) do
      conn
        |> put_flash(:info, "ログイン済みだぜ")
        |> redirect(to: user_path(conn, :index))
    else
      conn
        |> render("new.html")
    end
  end

  def create(conn, %{"name" => name, "password" => password}) do
    case Authentication.authenticate_user(name, password) do
      {:ok, user} ->
        conn
          |> put_session(:user_id, user.id)
          |> put_flash(:info, "ログインしたぜ")
          |> redirect(to: user_path(conn, :index))
      :error ->
        conn
          |> put_flash(:error, "ログインできないぜ")
          |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
      |> delete_session(:user_id)
      |> put_flash(:info, "ログアウトしたぜ")
      |> redirect(to: session_path(conn, :new))
  end
end
