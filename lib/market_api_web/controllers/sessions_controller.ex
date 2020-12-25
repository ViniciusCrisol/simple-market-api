defmodule MarketApiWeb.SessionsController do
  use MarketApiWeb, :controller

  alias MarketApiWeb.Auth.Guardian

  action_fallback MarketApiWeb.FallbackController

  def create(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("create.json", token: token)
    end
  end
end
