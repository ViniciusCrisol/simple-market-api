defmodule MarketApiWeb.FallbackController do
  use MarketApiWeb, :controller

  def call(conn, {:error, status, result}) do
    conn
    |> put_status(status)
    |> put_view(MarketApiWeb.ErrorView)
    |> render("error.json", result: result)
  end
end
