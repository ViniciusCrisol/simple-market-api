defmodule MarketApiWeb.UsersController do
  use MarketApiWeb, :controller

  alias MarketApiWeb.Auth.Guardian

  action_fallback MarketApiWeb.FallbackController

  def create(conn, params) do
    with {:ok, user} <- MarketApi.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", %{user: user, token: token})
    end
  end
end
