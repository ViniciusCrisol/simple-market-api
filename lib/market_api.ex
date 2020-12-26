defmodule MarketApi do
  alias MarketApi.Repositories.{User, Brand}

  defdelegate fetch_user(params), to: User.Get, as: :call
  defdelegate create_user(params), to: User.Create, as: :call

  defdelegate create_brand(params), to: Brand.Create, as: :call
end
