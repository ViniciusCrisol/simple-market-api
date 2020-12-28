defmodule MarketApi.Repositories.Brand.Update do
  alias Ecto.UUID
  alias MarketApi.Repo
  alias MarketApi.Schemas.Brand

  def call(%{"id" => uuid} = params) do
    case UUID.cast(uuid) do
      :error ->
        {:error, :unauthorized, "Invalid ID format!"}

      _ ->
        Repo.get(Brand, uuid)
        |> validate_params(params)
        |> update_brand()
    end
  end

  defp validate_params(nil, _params), do: {:error, :not_found, "Brand not found!"}

  defp validate_params(brand, %{"id" => brand_id, "name" => brand_name} = params) do
    case Repo.get_by(Brand, name: brand_name) do
      nil ->
        %{brand: brand, params: params}

      %{id: id} ->
        if id != brand_id,
          do: {:error, :unauthorized, "Name already registered!"},
          else: %{brand: brand, params: params}
    end
  end

  defp validate_params(brand, params), do: %{brand: brand, params: params}

  defp update_brand({:error, _status, _reason} = error), do: error

  defp update_brand(%{brand: brand, params: params}) do
    case Brand.update_changeset(brand, params) do
      %{valid?: false} = changeset -> {:error, :unauthorized, changeset}
      changeset -> Repo.update(changeset)
    end
  end
end
