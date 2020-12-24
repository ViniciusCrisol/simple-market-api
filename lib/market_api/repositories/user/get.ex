defmodule MarketApi.Repositories.User.Get do
  alias Ecto.UUID
  alias MarketApi.Repo
  alias MarketApi.Schemas.User

  def call(id) do
    id
    |> UUID.cast()
    |> get_user()
  end

  defp get_user(:error), do: {:error, :unauthorized, "Invalid ID format!"}

  defp get_user({:ok, uuid}) do
    uuid
    |> fetch_user()
    |> get_user()
  end

  defp get_user(nil), do: {:error, :not_found, "User not found!"}
  defp get_user(user), do: {:ok, user}

  defp fetch_user(uuid), do: Repo.get(User, uuid)
end
