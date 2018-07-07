defmodule PhxAppWeb.ThreadController do
  use PhxAppWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{"id" => id}) do

  end
end
