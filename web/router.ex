defmodule CodecheckSprint.Router do
  use CodecheckSprint.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CodecheckSprint.Plug.FetchUser
  end

  scope "/api", CodecheckSprint do
    pipe_through :api

    post "/login", UserController, :login
    resources "/users", UserController, only: ~w(index show create update)a
    get "/categories", CategoryController, :index

    resources "/projects", ProjectController, only: ~w(index show create update delete)a do
      resources "/comments", CommentController, only: ~w(index create update delete)a
    end
    post "/projects/:id/star", ProjectController, :star
    delete "/projects/:id/star", ProjectController, :unstar
  end

  scope "/", CodecheckSprint do
    pipe_through :browser

    get "/*path", PageController, :index
  end
end
