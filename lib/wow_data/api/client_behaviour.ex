defmodule WoWData.Api.ClientBehaviour do

  @callback get_request(binary()) :: {:ok, map()} | {:error, binary()}
end
