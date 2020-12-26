defmodule MarketApi.Repositories.User.Create do
  alias MarketApi.Repo
  alias MarketApi.Schemas.User

  def call(params) do
    params
    |> User.build()
    |> create_user()
  end

  defp create_user({:error, changeset}), do: {:error, :bad_request, changeset}

  defp create_user({:ok, %{email: email} = struct}) do
    case Repo.get_by(User, email: email) do
      nil -> Repo.insert(struct)
      _user -> {:error, :unauthorized, "E-mail already in use!"}
    end
  end
end
