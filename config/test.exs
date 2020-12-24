use Mix.Config

config :market_api, MarketApi.Repo,
  username: "postgres",
  password: "postgres",
  database: "market_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :market_api, MarketApiWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
