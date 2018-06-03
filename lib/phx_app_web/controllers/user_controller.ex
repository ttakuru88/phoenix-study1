defmodule PhxAppWeb.UserController do
  use PhxAppWeb, :controller

  alias PhxApp.{User, Repo}

  def index(conn, _params) do
    user_changeset = User.changeset_on_create(%User{}, _params)
    render conn, "index.html", user_changeset: user_changeset, users: load_users
  end

  def create(conn, %{"user" => user_params}) do
    user_changeset = User.changeset_on_create(%User{}, user_params)
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

  def edit(conn, %{"id" => id}) do
    user = User |> Repo.get(id)
    changeset = User.changeset_on_edit(user)
    render(conn, "edit.html", changeset: changeset, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = User |> Repo.get(id)
    changeset = User.changeset_on_edit(user, user_params)

    case Repo.update(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "更新したぜ")
        |> redirect(to: user_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "更新失敗")
        |> render("edit.html", changeset: changeset, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    User
    |> Repo.get(id)
    |> Repo.delete

    conn
    |> put_flash(:info, "削除しました")
    |> redirect(to: user_path(conn, :index))
  end

  defp load_users do
    User |> Repo.all
  end
end
