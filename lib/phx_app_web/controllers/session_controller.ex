defmodule PhxAppWeb.SessionController do
  use PhxAppWeb, :controller
  require Logger
  alias PhxApp.{User}

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"name" => name, "password" => password}) do
    case User.authenticate(name, password) do
      {:ok, user} ->
        conn
          |> put_session(:user_id, user.id)
          |> put_flash(:info, "ログインしたぜ")
          |> render "new.html"
      :error ->
        conn
          |> put_flash(:error, "ログインできないぜ")
          |> render "new.html"
    end
  end
end
