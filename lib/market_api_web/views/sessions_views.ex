defmodule MarketApiWeb.SessionsView do
  use MarketApiWeb, :view

  def render("create.json", %{token: token}) do
    %{token: token}
  end
end
