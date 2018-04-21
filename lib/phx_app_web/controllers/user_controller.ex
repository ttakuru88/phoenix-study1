defmodule PhxAppWeb.UserController do
  use PhxAppWeb, :controller

  alias PhxApp.User

  def index(conn, _params) do
    user_changeset = User.changeset(%User{}, _params)
    render conn, "index.html", user_changeset: user_changeset
  end

  def create(conn, _params) do
    render conn, "index.html"
  end
end
