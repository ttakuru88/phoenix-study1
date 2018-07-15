defmodule PhxAppWeb.ThreadController do
  use PhxAppWeb, :controller

  alias PhxApp.{Thread, Repo, Authentication}

  def index(conn, _params) do
    render conn, "index.html", threads: load_threads(), changeset: Thread.changeset(%Thread{})
  end

  def show(conn, %{"id" => id}) do
    thread = Thread |> Repo.get(id)
    render conn, "show.html", thread: thread
  end

  def create(conn, %{"thread" => params}) do
    changeset = Thread.changeset(%Thread{user_id: Authentication.current_user(conn).id}, params)
    case Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "スレッド作成した")
        |> redirect(to: thread_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "作成失敗した")
        |> render("index.html", threads: load_threads(), changeset: changeset)
    end
  end

  defp load_threads() do
    Thread |> Repo.all
  end
end
