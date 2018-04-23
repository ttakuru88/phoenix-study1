defmodule PhxAppWeb.UserController do
  use PhxAppWeb, :controller

  alias PhxApp.{User, Repo}

  def index(conn, _params) do
    user_changeset = User.changeset(%User{}, _params)
    render conn, "index.html", user_changeset: user_changeset, users: load_users
  end

  def create(conn, %{"user" => user_params}) do
    user_changeset = User.changeset(%User{}, user_params)
    case Repo.insert(user_changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "ユーザー作ったぜ")
        |> redirect(to: user_path(conn, :index))
      {:error, user_changeset} ->
        conn
        |> put_flash(:error, "作成失敗")
        |> render("index.html", user_changeset: user_changeset, users: load_users)
    end
  end

  defp load_users do
    User |> Repo.all
  end
end
