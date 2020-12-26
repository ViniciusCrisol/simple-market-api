defmodule MarketApi.Schemas.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias MarketApi.Schemas.{Category, Brand}

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "products" do
    field :name, :string
    field :price, :float
    field :description, :string
    belongs_to(:brand, Brand)
    belongs_to(:category, Category)
    timestamps()
  end

  @required_params [:name, :price, :description, :brand_id, :category_id]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params), do: create_changeset(%__MODULE__{}, params)
  def changeset(product, params), do: create_changeset(product, params)

  defp create_changeset(module_or_product, params) do
    module_or_product
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
