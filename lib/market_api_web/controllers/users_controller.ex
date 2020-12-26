defmodule MarketApiWeb.UsersController do
  use MarketApiWeb, :controller

  alias MarketApi.Repo
  alias MarketApi.Schemas.User
  alias MarketApiWeb.Auth.Guardian

  action_fallback MarketApiWeb.FallbackController

  def create(conn, %{"email" => email} = params) do
    case Repo.get_by(User, email: email) do
      nil ->
        with {:ok, user} <- MarketApi.create_user(params),
             {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
          conn
          |> put_status(:created)
          |> render("create.json", %{user: user, token: token})
        end

      _user ->
        {:error, :unauthorized, "E-mail already in use!"}
    end
  end
end
