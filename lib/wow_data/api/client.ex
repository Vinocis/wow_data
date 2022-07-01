defmodule WoWData.Api.Client do
  use Tesla
  alias WoWData.Api.ClientBehaviour
  alias WoWData.Auth

  plug Tesla.Middleware.BaseUrl, "https://us.api.blizzard.com/data/wow/"
  plug Tesla.Middleware.JSON

  @behaviour ClientBehaviour

  @impl ClientBehaviour
  def get_request(endpoint) do

    endpoint
    |> get!()
    |> handle_response()
  end

  defp handle_response(response) do
    case response.status do
      401 ->
        refresh_token(response.url)

      404 ->
        {:error, "Not Found"}

      200 ->
        {:ok, response.body}
    end
  end

  def refresh_token(url) do
    {:ok, refreshed_token} = Auth.refresh()

    url
    |> String.graphemes()
    |> Enum.drop(-34)
    |> List.to_string()
    |> Kernel.<>(refreshed_token.value)
    |> get_request()
  end
end
