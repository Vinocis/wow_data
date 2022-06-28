defmodule WoWData.Repo do
  use Ecto.Repo,
    otp_app: :wow_data,
    adapter: Ecto.Adapters.Postgres
end
