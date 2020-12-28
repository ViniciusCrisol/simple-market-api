defmodule MarketApi.Repositories.Category.Update do
  alias Ecto.UUID
  alias MarketApi.Repo
  alias MarketApi.Schemas.Category

  def call(%{"id" => uuid} = params) do
    case UUID.cast(uuid) do
      :error ->
        {:error, :unauthorized, "Invalid ID format!"}

      _ ->
        Repo.get(Category, uuid)
        |> validate_params(params)
        |> update_category()
    end
  end

  defp validate_params(nil, _params), do: {:error, :not_found, "Category not found!"}

  defp validate_params(category, %{"id" => category_id, "name" => category_name} = params) do
    case Repo.get_by(Category, name: category_name) do
      nil ->
        %{category: category, params: params}

      %{id: id} ->
        if id != category_id,
          do: {:error, :unauthorized, "Name already registered!"},
          else: %{category: category, params: params}
    end
  end

  defp validate_params(category, params), do: %{category: category, params: params}

  defp update_category({:error, _status, _reason} = error), do: error

  defp update_category(%{category: category, params: params}) do
    case Category.update_changeset(category, params) do
      %{valid?: false} = changeset -> {:error, :unauthorized, changeset}
      changeset -> Repo.update(changeset)
    end
  end
end
