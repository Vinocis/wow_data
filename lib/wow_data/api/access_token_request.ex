defmodule WoWData.Api.AccessTokenRequest do
  use Tesla
  alias WoWData.Api.AccessTokenBehaviour

  plug Tesla.Middleware.BasicAuth,
    username: user(),
    password: password()

  @behaviour AccessTokenBehaviour

  @impl AccessTokenBehaviour
  def get_token do
    mp =
      Tesla.Multipart.new()
      |> Tesla.Multipart.add_content_type_param("multipart/form-data")
      |> Tesla.Multipart.add_field("grant_type", "client_credentials")

    "https://us.battle.net/oauth/token"
    |> post!(mp)
    |> handle_response()
  end

  defp handle_response(response) do
    case response.status do
      401 ->
        IO.inspect(user(), label: "USUARIO")
        IO.inspect(password(), label: "SENHA")
        #{:error, "Unauthorized"}

      200 ->
        response.body
        |> Jason.decode!()
        |> Map.fetch("access_token")
    end
  end

  defp user, do: Application.get_env(:wow_data, :access_token)[:user]
  defp password, do: Application.get_env(:wow_data, :access_token)[:password]
end
