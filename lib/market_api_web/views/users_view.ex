defmodule MarketApiWeb.UsersView do
  use MarketApiWeb, :view

  alias MarketApi.Schemas.User

  def render("create.json", %{
        token: token,
        user: %User{id: id, name: name, email: email, inserted_at: inserted_at}
      }) do
    %{
      token: token,
      user: %{id: id, name: name, email: email, inserted_at: inserted_at}
    }
  end
end
