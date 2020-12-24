defmodule MarketApi.Repo do
  use Ecto.Repo,
    otp_app: :market_api,
    adapter: Ecto.Adapters.Postgres
end
