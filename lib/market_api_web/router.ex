defmodule MarketApiWeb.Router do
  use MarketApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug MarketApiWeb.Auth.Pipeline
  end

  scope "/api", MarketApiWeb do
    post "/users", UsersController, :create
    post "/users/session", SessionsController, :create
  end

  scope "/api", MarketApiWeb do
    pipe_through [:api, :auth]

    post "/brands", BrandsController, :create
    post "/categories", CategoriesController, :create
    post "/products", ProductsController, :create
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: MarketApiWeb.Telemetry
    end
  end
end
