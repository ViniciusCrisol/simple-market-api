defmodule MarketApiWeb.ProductsView do
  use MarketApiWeb, :view

  alias MarketApi.Schemas.Product

  def render("create.json", %{
        product: %Product{
          id: id,
          name: name,
          description: description,
          brand: %{id: brand_id, name: brand_name, inserted_at: brand_inserted_at},
          category: %{id: category_id, name: category_name, inserted_at: category_inserted_at},
          inserted_at: inserted_at
        }
      }) do
    %{
      message: "Product created!",
      product: %{
        id: id,
        name: name,
        description: description,
        brand: %{id: brand_id, name: brand_name, inserted_at: brand_inserted_at},
        categoy: %{id: category_id, name: category_name, inserted_at: category_inserted_at},
        inserted_at: inserted_at
      }
    }
  end
end
