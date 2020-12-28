defmodule MarketApi.Schemas.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias MarketApi.Schemas.{Category, Brand}

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  @product_params [:name, :price, :quantity, :description, :brand_id, :category_id]

  schema "products" do
    field :name, :string
    field :price, :float
    field :quantity, :integer
    field :description, :string

    timestamps()
    belongs_to(:brand, Brand)
    belongs_to(:category, Category)
  end

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params), do: create_changeset(%__MODULE__{}, params)
  def changeset(product, params), do: create_changeset(product, params)

  defp create_changeset(module_or_product, params) do
    module_or_product
    |> cast(params, @product_params)
    |> validate_length(:name, min: 5)
    |> validate_required(@product_params)
  end

  def update_changeset(product, params) do
    product
    |> cast(params, @product_params)
    |> validate_length(:name, min: 5)
  end
end
