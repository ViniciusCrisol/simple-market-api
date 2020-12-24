defmodule MarketApiWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Plug.Conn
      import Phoenix.ConnTest
      import MarketApiWeb.ConnCase

      alias MarketApiWeb.Router.Helpers, as: Routes

      @endpoint MarketApiWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(MarketApi.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(MarketApi.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
