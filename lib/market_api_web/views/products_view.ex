defmodule MarketApiWeb.ProductsView do
  use MarketApiWeb, :view

  alias MarketApi.Schemas.{Product, Brand, Category}

  def render("create_and_update.json", %{
        product: %Product{
          id: id,
          name: name,
          quantity: quantity,
          description: description,
          inserted_at: inserted_at,
          brand: %Brand{id: brand_id, name: brand_name, inserted_at: brand_inserted_at},
          category: %Category{
            id: category_id,
            name: category_name,
            inserted_at: category_inserted_at
          }
        }
      }) do
    %{
      id: id,
      name: name,
      quantity: quantity,
      description: description,
      inserted_at: inserted_at,
      brand: %{id: brand_id, name: brand_name, inserted_at: brand_inserted_at},
      category: %{id: category_id, name: category_name, inserted_at: category_inserted_at}
    }
  end
end
