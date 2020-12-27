defmodule MarketApi.Repositories.Product.Update do
  alias Ecto.UUID
  alias MarketApi.Repo
  alias MarketApi.Schemas.Product

  def call(%{"id" => uuid} = params) do
    uuid
    |> UUID.cast()
    |> get_product(params)
    |> get_product_category()
    |> get_product_brand()
  end

  defp get_product(:error, _params), do: {:error, :unauthorized, "Invalid ID format!"}

  defp get_product({:ok, uuid}, params) do
    Repo.get(Product, uuid)
    |> update_product(params)
  end

  defp update_product(nil, _params), do: {:error, :not_found, "Product not found!"}

  defp update_product(product, params) do
    product
    |> Product.update_changeset(params)
    |> Repo.update()
  end

  defp get_product_category({:error, _status, _reason} = error), do: error
  defp get_product_category({:ok, product}), do: {:ok, Repo.preload(product, :category)}

  defp get_product_brand({:error, _status, _reason} = error), do: error
  defp get_product_brand({:ok, product}), do: {:ok, Repo.preload(product, :brand)}
end
