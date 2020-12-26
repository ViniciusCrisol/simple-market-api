defmodule MarketApi.Repositories.Brand.Create do
  alias MarketApi.Repo
  alias MarketApi.Schemas.Brand

  def call(params) do
    params
    |> Brand.build()
    |> create_brand()
  end

  defp create_brand({:error, changeset}), do: {:error, :bad_request, changeset}

  defp create_brand({:ok, %{name: name} = struct}) do
    case Repo.get_by(Brand, name: name) do
      nil -> Repo.insert(struct)
      _brand -> {:error, :unauthorized, "Brand already registered!"}
    end
  end
end
