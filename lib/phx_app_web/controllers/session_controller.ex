defmodule PhxAppWeb.SessionController do
  use PhxAppWeb, :controller
  require Logger
  alias PhxApp.{User}

  def new(conn, _params) do
    if User.signed_in?(conn) do
      redirect(conn, to: "/")
    else
      render conn, "new.html"
    end
  end

  def create(conn, %{"name" => name, "password" => password}) do
    case User.authenticate(name, password) do
      {:ok, user} ->
        conn
          |> put_session(:user_id, user.id)
          |> put_flash(:info, "ログインしたぜ")
          |> redirect(to: "/")
      :error ->
        conn
          |> put_flash(:error, "ログインできないぜ")
          |> render "new.html"
    end
  end

  def delete(conn, _) do
    conn
      |> delete_session(:user_id)
      |> put_flash(:info, "ログアウトしたぜ")
      |> redirect(to: "/sessions/new")
  end
end
