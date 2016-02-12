defmodule CodecheckSprint.Router do
  use CodecheckSprint.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CodecheckSprint do
    pipe_through :api

    resources "/projects", ProjectController, only: ~w(index show create delete)a
  end

  scope "/", CodecheckSprint do
    pipe_through :browser

    get "/*path", PageController, :index
  end
end
