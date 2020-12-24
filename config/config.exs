use Mix.Config

config :market_api,
  ecto_repos: [MarketApi.Repo]

config :market_api, MarketApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "C3gQfrOvx0nYJO1rnSwGmvkF1eSTQguJKCLB2iEKsBI+eovztOnZU5Pz4yqInP6r",
  render_errors: [view: MarketApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: MarketApi.PubSub,
  live_view: [signing_salt: "MtpvvaRv"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"

config :market_api, MarketApiWeb.Auth.Guardian,
  issuer: "market_api",
  secret_key: "ntcliUkYeo1bNJMnZ6gd82BsxCQPLQ6pjwTZRdrhwVnd+d1uSR2s/8LzUnzhfQYt"

config :market_api, MarketApiWeb.Auth.Pipeline,
  module: MarketApiWeb.Auth.Guardian,
  error_handler: MarketApiWeb.Auth.ErrorHandler
