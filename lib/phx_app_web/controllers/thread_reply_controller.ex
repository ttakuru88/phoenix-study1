defmodule PhxAppWeb.ThreadReplyController do
  use PhxAppWeb, :controller
  alias PhxApp.{Authentication, ThreadReply, Repo}

  def create(conn, %{"thread_reply" => params, "thread_id" => thread_id}) do
    user = Authentication.current_user(conn)
    thread_id = thread_id |> String.to_integer
    changeset = ThreadReply.changeset(%ThreadReply{user_id: user.id, thread_id: thread_id}, params)
    case Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "糞リプ完了！")
        |> redirect(to: thread_path(conn, :show, thread_id))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "糞リプ失敗！！")
        |> redirect(to: thread_path(conn, :show, thread_id))
    end
  end
end
