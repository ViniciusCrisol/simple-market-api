defmodule MarketApiWeb.CategoriesView do
  use MarketApiWeb, :view

  alias MarketApi.Schemas.Category

  def render("create_and_update.json", %{
        category: %Category{
          id: id,
          name: name,
          description: description,
          inserted_at: inserted_at
        }
      }) do
    %{
      id: id,
      name: name,
      description: description,
      inserted_at: inserted_at
    }
  end
end
