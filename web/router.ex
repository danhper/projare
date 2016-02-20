defmodule Projare.Router do
  use Projare.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Projare.Plug.FetchUser
  end

  scope "/api", Projare do
    pipe_through :api

    post "/login", UserController, :login
    post "/login/facebook", UserController, :facebook_login
    resources "/users", UserController, only: ~w(create)a
    get "/categories", CategoryController, :index

    resources "/projects", ProjectController, only: ~w(index show create update delete)a do
      resources "/comments", CommentController, only: ~w(index create update delete)a
    end
    post "/projects/:id/star", ProjectController, :star
    delete "/projects/:id/star", ProjectController, :unstar
  end

  scope "/", Projare do
    pipe_through :browser

    get "/*path", PageController, :index
  end
end
