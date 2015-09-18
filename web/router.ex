defmodule Echo.Router do
  use Echo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  scope "/", Echo do
    pipe_through :browser

    get "/", SayingsController, :random
    get "/quotes/new", SayingsController, :new
    get "/quotes/:cypher", SayingsController, :show
    post "/", SayingsController, :create
  end
end
