defmodule MarketApi do
  alias MarketApi.Repositories.{User, Brand, Category, Product}

  defdelegate fetch_user(params), to: User.Get, as: :call
  defdelegate create_user(params), to: User.Create, as: :call

  defdelegate create_brand(params), to: Brand.Create, as: :call

  defdelegate create_category(params), to: Category.Create, as: :call

  defdelegate create_product(params), to: Product.Create, as: :call
end
