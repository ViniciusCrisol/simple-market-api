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

    resources "/brands", BrandsController, only: [:create, :update]
    resources "/categories", CategoriesController, [:create, :update]
    resources "/products", ProductsController, only: [:create, :update]
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: MarketApiWeb.Telemetry
    end
  end
end
