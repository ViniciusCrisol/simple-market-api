defmodule MarketApi.Repositories.User.Create do
  alias MarketApi.Repo
  alias MarketApi.Schemas.User

  def call(params) do
    params
    |> User.build()
    |> create_user()
  end

  defp create_user({:ok, struct}), do: Repo.insert(struct)
  defp create_user({:error, changeset}), do: {:error, :bad_request, changeset}
end
