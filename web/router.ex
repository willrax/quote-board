defmodule Echo.Router do
  use Echo.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Echo do
    pipe_through :api

    options  "/sayings", SayingController, :options
    resources "/sayings", SayingController
  end
end
