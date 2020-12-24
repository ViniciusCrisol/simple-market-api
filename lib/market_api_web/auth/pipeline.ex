defmodule MarketApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :market_api

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
