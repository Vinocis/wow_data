defmodule WoWData.Models.AccessToken do
  use Ecto.Schema
  import Ecto.Changeset

  schema "access_tokens" do
    field :value, :string

    timestamps()
  end

  def changeset(model, attrs) do
    model
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
