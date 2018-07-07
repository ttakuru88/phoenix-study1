defmodule PhxAppWeb.Router do
  use PhxAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhxAppWeb do
    pipe_through :browser # Use the default browser stack

    resources "/", MessageController, only: [:index]
    resources "/users", UserController, only: [:index, :create, :delete, :edit, :update]
    resources "/sessions", SessionController, only: [:new, :create]
    delete "/sessions", SessionController, :delete
    resources "/threads", ThreadController, only: [:index, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxAppWeb do
  #   pipe_through :api
  # end
end
