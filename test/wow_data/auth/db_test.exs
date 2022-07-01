defmodule WoWData.Auth.DbTest do
  alias WoWData.Auth.Db
  alias WoWData.Models.AccessToken
  use WoWData.DataCase

  describe "create/3" do
    test "pass with valid arguments" do
      token = Db.create(%AccessToken{}, AccessToken, %{value: "access_token"})

      assert {:ok, _} = token
    end

    test "fails with invalid arguments" do
      token = Db.create(%AccessToken{}, AccessToken, %{value: 1})

      assert {:error, _} = token
    end
  end

  describe "get/2" do
    test "pass with valid arguments" do
      {:ok, token} = Db.create(%AccessToken{}, AccessToken, %{value: "access_token"})
      id = token.id

      assert {:ok, _} = Db.get(AccessToken, id)
    end

    test "fails with invalid arguments" do
     {:ok, token} = Db.create(%AccessToken{}, AccessToken, %{value: "access_token"})
      id = token.id

      assert {:error, _} = Db.get(AccessToken, id - 1)
    end

    test "fails if the data doesn't exists" do

      assert {:error, _} = Db.get(AccessToken, 1)
    end
  end

  describe "update/3" do
    test "pass with valid arguments" do
      {:ok, token} = Db.create(%AccessToken{}, AccessToken, %{value: "access_token"})
      id = token.id

      assert {:ok, _} = Db.update(AccessToken, %{value: "new_token"}, id)
    end

    test "fails if the field to be updated are not of a valid type" do
      {:ok, token} = Db.create(%AccessToken{}, AccessToken, %{value: "access_token"})
      id = token.id

      assert {:error, _} = Db.update(AccessToken, %{value: 2}, id)
    end

    test "fails with invalid arguments" do
      {:ok, token} = Db.create(%AccessToken{}, AccessToken, %{value: "access_token"})
      id = token.id

      assert_raise Protocol.UndefinedError, fn -> Db.update(InvalidModule, %{value: 2}, id) end
    end
  end
end
