defmodule MarketApi.Application do
  use Application

  def start(_type, _args) do
    children = [
      MarketApi.Repo,
      MarketApiWeb.Telemetry,
      {Phoenix.PubSub, name: MarketApi.PubSub},
      MarketApiWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: MarketApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    MarketApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
