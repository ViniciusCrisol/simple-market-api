defmodule MarketApi.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias MarketApi.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import MarketApi.DataCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(MarketApi.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(MarketApi.Repo, {:shared, self()})
    end

    :ok
  end

  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
