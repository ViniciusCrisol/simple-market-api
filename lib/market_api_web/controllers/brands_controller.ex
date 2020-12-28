defmodule MarketApiWeb.BrandsController do
  use MarketApiWeb, :controller

  action_fallback MarketApiWeb.FallbackController

  def create(conn, params) do
    MarketApi.create_brand(params)
    |> handle_response(conn, "create_and_update.json", :created)
  end

  def update(conn, params) do
    params
    |> MarketApi.update_brand()
    |> handle_response(conn, "create_and_update.json", :ok)
  end

  defp handle_response({:error, _error_status, _reason} = error, _conn, _view, _status), do: error

  defp handle_response({:ok, brand}, conn, view, status) do
    conn
    |> put_status(status)
    |> render(view, brand: brand)
  end
end
