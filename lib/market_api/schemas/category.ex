defmodule MarketApi.Schemas.Category do
  use Ecto.Schema
  import Ecto.Changeset

  alias MarketApi.Schemas.Product

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  @category_params [:name, :description]

  schema "categories" do
    field :name, :string
    field :description, :string

    timestamps()
    has_many(:product, Product)
  end

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params), do: create_changeset(%__MODULE__{}, params)
  def changeset(category, params), do: create_changeset(category, params)

  defp create_changeset(module_or_category, params) do
    module_or_category
    |> cast(params, @category_params)
    |> validate_length(:name, min: 5)
    |> validate_required(@category_params)
  end

  def update_changeset(category, params) do
    category
    |> cast(params, @category_params)
    |> validate_length(:name, min: 5)
  end
end
