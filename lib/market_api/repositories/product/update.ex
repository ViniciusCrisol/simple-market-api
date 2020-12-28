defmodule MarketApi.Repositories.Product.Update do
  alias Ecto.UUID
  alias MarketApi.Repo
  alias MarketApi.Schemas.Product

  def call(%{"id" => uuid} = params) do
    case UUID.cast(uuid) do
      :error ->
        {:error, :unauthorized, "Invalid ID format!"}

      _ ->
        Repo.get(Product, uuid)
        |> update_product(params)
        |> get_product_category()
        |> get_product_brand()
    end
  end

  defp update_product(nil, _params), do: {:error, :not_found, "Product not found!"}

  defp update_product(product, params) do
    case Product.update_changeset(product, params) do
      %{valid?: false} = changeset -> {:error, :unauthorized, changeset}
      changeset -> Repo.update(changeset)
    end
  end

  defp get_product_category({:error, _status, _reason} = error), do: error
  defp get_product_category({:ok, product}), do: {:ok, Repo.preload(product, :category)}

  defp get_product_brand({:error, _status, _reason} = error), do: error
  defp get_product_brand({:ok, product}), do: {:ok, Repo.preload(product, :brand)}
end
