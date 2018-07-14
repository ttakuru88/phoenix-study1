defmodule PhxAppWeb.ThreadController do
  use PhxAppWeb, :controller

  alias PhxApp.{Thread, Repo}

  def index(conn, _params) do
    threads = Thread |> Repo.all

    render conn, "index.html", threads: threads, changeset: Thread.changeset(%Thread{})
  end

  def show(conn, %{"id" => id}) do

  end
end
