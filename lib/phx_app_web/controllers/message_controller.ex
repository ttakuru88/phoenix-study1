defmodule PhxAppWeb.MessageController do
  use PhxAppWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
