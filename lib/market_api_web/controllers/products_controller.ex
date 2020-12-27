defmodule MarketApiWeb.ProductsController do
  use MarketApiWeb, :controller

  action_fallback MarketApiWeb.FallbackController

  def create(conn, params) do
    MarketApi.create_product(params)
    |> handle_response(conn, "create_and_update.json", :created)
  end

  def update(conn, params) do
    params
    |> MarketApi.update_product()
    |> handle_response(conn, "create_and_update.json", :ok)
  end

  defp handle_response({:error, _error_status, _reason} = error, _conn, _view, _status), do: error

  defp handle_response({:ok, product}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, product: product)
  end
end
