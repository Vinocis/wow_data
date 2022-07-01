defmodule WoWData.Auth.Db do
  alias WoWData.Repo

  def create(schema, module, attrs) do
    schema
    |> module.changeset(attrs)
    |> Repo.insert()
  end

  def get(module, id \\ 1) do
    data = Repo.get(module, id)

    if data, do: {:ok, data}, else: {:error, :noent}
  end

  def update(module, new_value, id \\ 1) do
    data = get(module, id)

    case data do
      {:ok, data} ->
        data
        |> module.changeset(new_value)
        |> Ecto.Changeset.force_change(:value, new_value["value"])
        |> Repo.update()

      {:error, reason} ->
        {:error, reason}
    end
  end
end
