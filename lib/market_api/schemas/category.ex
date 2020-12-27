defmodule MarketApi.Schemas.Category do
  use Ecto.Schema
  import Ecto.Changeset

  alias MarketApi.Schemas.Product

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "categories" do
    field :name, :string
    field :description, :string

    timestamps()
    has_many(:product, Product)
  end

  @required_params [:name, :description]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params), do: create_changeset(%__MODULE__{}, params)
  def changeset(category, params), do: create_changeset(category, params)

  defp create_changeset(module_or_category, params) do
    module_or_category
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
