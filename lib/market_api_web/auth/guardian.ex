defmodule MarketApiWeb.Auth.Guardian do
  use Guardian, otp_app: :market_api

  alias Ecto.UUID
  alias MarketApi.Repo
  alias MarketApi.Schemas.User

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> MarketApi.fetch_user()
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    user_id
    |> UUID.cast()
    |> authenticate_user(password)
  end

  defp authenticate_user(:error, _password), do: {:error, :unauthorized, "Invalid ID format!"}

  defp authenticate_user({:ok, user_id}, password) do
    case Repo.get(Trainer, user_id) do
      nil -> {:error, :not_found, "User not found!"}
      user -> validate_password(user, password)
    end
  end

  defp validate_password(%User{password_hash: hash} = user, password) do
    case Argon2.verify_pass(password, hash) do
      true -> create_token(user)
      false -> {:error, :unauthorized, "User unauthorized!"}
    end
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, token}
  end
end
