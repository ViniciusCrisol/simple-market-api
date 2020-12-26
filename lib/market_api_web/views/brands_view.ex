defmodule MarketApiWeb.BrandsView do
  use MarketApiWeb, :view

  alias MarketApi.Schemas.Brand

  def render(
        "create.json",
        %{brand: %Brand{id: id, name: name, description: description, inserted_at: inserted_at}}
      ) do
    %{
      message: "Brand created!",
      brand: %{
        id: id,
        name: name,
        description: description,
        inserted_at: inserted_at
      }
    }
  end
end
