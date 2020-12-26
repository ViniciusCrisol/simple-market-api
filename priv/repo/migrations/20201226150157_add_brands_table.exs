defmodule MarketApi.Repo.Migrations.AddBrandsTable do
  use Ecto.Migration

  def change do
    create table(:brands, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :description, :string
      timestamps()
    end
    create unique_index(:brands, [:name])
  end
end
