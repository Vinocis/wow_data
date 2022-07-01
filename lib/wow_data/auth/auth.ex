defmodule WoWData.Auth do
  alias WoWData.Auth.Db
  alias WoWData.Models.AccessToken

  def get_from_database(id \\ 1) do
    access_token = Db.get(AccessToken, id)

    case access_token do
      {:ok, _} ->
        access_token

      {:error, _} ->
        get_from_api()

    end
  end

  defp get_from_api do
    {:ok, token} = token_request().get_token()

    Db.create(
      %AccessToken{},
      AccessToken,
      %{value: token}
    )
  end

  def refresh(id \\ 1) do
    {:ok, token} = token_request().get_token()

    Db.update(AccessToken, %{"value" => token}, id)
  end

  defp token_request, do: Application.get_env(:wow_data, :access_token_request)[:impl]
end
