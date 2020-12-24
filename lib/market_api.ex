defmodule MarketApi do
  alias MarketApi.Repositories.User

  defdelegate fetch_user(params), to: User.Get, as: :call
  defdelegate create_user(params), to: User.Create, as: :call
end
