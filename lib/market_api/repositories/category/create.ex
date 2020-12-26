defmodule MarketApi.Repositories.Category.Create do
  alias MarketApi.Repo
  alias MarketApi.Schemas.Category

  def call(params) do
    params
    |> Category.build()
    |> create_category()
  end

  defp create_category({:error, changeset}), do: {:error, :bad_request, changeset}

  defp create_category({:ok, %{name: name} = struct}) do
    case Repo.get_by(Category, name: name) do
      nil -> Repo.insert(struct)
      _category -> {:error, :unauthorized, "Category already registered!"}
    end
  end
end
