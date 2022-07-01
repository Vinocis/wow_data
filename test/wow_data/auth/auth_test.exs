defmodule WowData.Auth.AuthTest do
  alias WoWData.Api.AccessTokenBehaviourMock
  alias WoWData.Auth
  alias WoWData.Auth.Db
  alias WoWData.Models.AccessToken
  use WoWData.DataCase

  import Mox

  describe "get_from_database/1" do
    test "pass with valid args and the token exists in the database" do
      {:ok, token} = Db.create(%AccessToken{}, AccessToken, %{value: "access_token"})

      assert {:ok, _} = Auth.get_from_database(token.id)
    end

    test "create the token in the database if doesn't exists" do
      expect(AccessTokenBehaviourMock, :get_token, fn -> {:ok, "new_token"} end)

      assert {:ok, token} = Auth.get_from_database()
      assert {:ok, _} = Db.get(AccessToken, token.id)
    end
  end

  describe "refresh/0" do
    test "pass with valid ags and the token exists in the database" do
      {:ok, token} = Db.create(%AccessToken{}, AccessToken, %{value: "access_token"})
      expect(AccessTokenBehaviourMock, :get_token, fn -> {:ok, "new_token"} end)

      assert {:ok, _} = Auth.refresh(token.id)
    end

    test "fails if the token doesn't exists" do
      expect(AccessTokenBehaviourMock, :get_token, fn -> {:ok, "new_token"} end)

      assert {:error, :noent} = Auth.refresh()
    end
  end
end
