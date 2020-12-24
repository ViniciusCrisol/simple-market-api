defmodule MarketApiWeb.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Phoenix.ChannelTest
      import MarketApiWeb.ChannelCase

      @endpoint MarketApiWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(MarketApi.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(MarketApi.Repo, {:shared, self()})
    end

    :ok
  end
end
