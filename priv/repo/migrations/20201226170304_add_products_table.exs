defmodule MarketApi.Repo.Migrations.AddProductsTable do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :price, :float
      add :description, :string
      add :brand_id, references(:brands, type: :uuid, on_delete: :delete_all), null: false
      add :category_id, references(:categories, type: :uuid, on_delete: :delete_all), null: false
      timestamps()
    end
  end
end
