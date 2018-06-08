defmodule PhxAppWeb.SessionController do
  use PhxAppWeb, :controller
  require Logger
  alias PhxApp.{User}

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"name" => name, "password" => password}) do
    user = User.authenticate(name, password)
    if user do
      conn = put_session(conn, :user_id, user.id)
      render conn, "new.html"
    else
      render conn, "new.html"
    end
  end
end
