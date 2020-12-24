defmodule MarketApiWeb.UsersView do
  use MarketApiWeb, :view

  alias MarketApi.Schemas.User

  def render("create.json", %{
        user: %User{id: id, name: name, email: email, inserted_at: inserted_at},
        token: token
      }) do
    %{
      message: "User created!",
      user: %{
        id: id,
        name: name,
        email: email,
        inserted_at: inserted_at
      },
      token: token
    }
  end
end
