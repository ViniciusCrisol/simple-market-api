defmodule MarketApi.Repositories.Product.Create do
  alias MarketApi.Repo
  alias MarketApi.Schemas.{Product, Category, Brand}

  def call(params) do
    params
    |> Product.build()
    |> validate_category()
    |> validate_brand()
    |> create_product()
    |> get_product_category()
    |> get_product_brand()
  end

  defp validate_category({:error, changeset}), do: {:error, :bad_request, changeset}

  defp validate_category({:ok, %{category_id: category_id} = struct}) do
    case Repo.get_by(Category, id: category_id) do
      nil -> {:error, :not_found, "Category does not exists!"}
      _category -> {:ok, struct}
    end
  end

  defp validate_brand({:error, _status, _message} = error), do: error

  defp validate_brand({:ok, %{brand_id: brand_id} = struct}) do
    case Repo.get_by(Brand, id: brand_id) do
      nil -> {:error, :not_found, "Brand does not exists!"}
      _brand -> {:ok, struct}
    end
  end

  defp create_product({:error, _status, _message} = error), do: error
  defp create_product({:ok, struct}), do: Repo.insert(struct)

  defp get_product_category({:error, _status, _reason} = error), do: error
  defp get_product_category({:ok, product}), do: {:ok, Repo.preload(product, :category)}

  defp get_product_brand({:error, _status, _reason} = error), do: error
  defp get_product_brand({:ok, product}), do: {:ok, Repo.preload(product, :brand)}
end
