defmodule PhxAppWeb.UserController do
  use PhxAppWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, _params) do
    render conn, "index.html"
  end
end
