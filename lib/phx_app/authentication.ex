defmodule PhxApp.Authentication do
  alias PhxApp.{User, Repo}

  def authenticate_user(name, password) do
    user = Repo.get_by(User, name: name)
    case checkpw(user, password) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  defp checkpw(nil, password) do
    false
  end

  defp checkpw(user, password) do
    Comeonin.Argon2.checkpw(password, user.hashed_password)
  end

  def current_user(conn) do
    case Plug.Conn.get_session(conn, :user_id) do
      nil -> nil
      user_id -> Repo.get(User, user_id)
    end
  end

  def signed_in?(conn) do
    !!current_user(conn)
  end
end
